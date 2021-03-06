#!/usr/bin/env python
"""
SORD simulation
"""
import os, json, shutil
import numpy as np
import pyproj
import cst
s_ = cst.sord.get_slices()
prm = {}

# resolution and parallelization
dx = 50.0;   prm['nproc3'] = [1, 32, 480]; nstripe = 32
dx = 100.0;  prm['nproc3'] = [1, 4, 240];  nstripe = 16
dx = 200.0;  prm['nproc3'] = [1, 1, 120];  nstripe = 8
dx = 500.0;  prm['nproc3'] = [1, 1, 2];    nstripe = 2
dx = 1000.0; prm['nproc3'] = [1, 1, 2];    nstripe = 1
dx = 4000.0; prm['nproc3'] = [1, 1, 1];    nstripe = 1

# I/O
surf_out = True
surf_out = False
prm['itstats'] = 10
prm['itio'] = nstripe * 100

# surface topography
surf = 'topo'
surf = 'flat'

# align receivers to mesh nodes
register = True
register = False

# cvm version
cwd = os.getcwd()
for cvm in 'cvms', 'cvmh', 'cvmg':

    # simulation name
    mesh = 'ch%04.0f%s' % (dx, cvm[-1])
    name = mesh + surf[0]

    # mesh metadata
    mesh = os.path.join(cwd, 'run', 'mesh', mesh) + os.sep
    meta = open(mesh + 'meta.json')
    meta = json.load(meta)
    dtype = meta['dtype']
    dx, dy, dz = meta['delta']
    nx, ny, nz = meta['shape']
    origin = meta['origin']
    prm['npml'] = meta['npml']

    # translate projection to lower left origin
    x, y = meta['bounds'][:2]
    proj = pyproj.Proj(**meta.projection)
    proj = cst.coord.Transform(proj, translate=(-x[0], -y[0]))

    # dimensions
    dt = dx / 16000.0
    dt = dx / 20000.0
    nt = int(90.0 / dt + 1.00001)
    prm['delta'] = [dx, dy, dz, dt]
    prm['shape'] = [nx, ny, nz, nt]

    # material
    prm['rho'] = ([], '=<', 'mesh-rho.bin')
    prm['vp'] = ([], '=<', 'mesh-vp.bin')
    prm['vs'] = ([], '=<', 'mesh-vs.bin')
    prm['hourglass'] = [1.0, 1.0]
    prm['vp1'] = 1500.0
    prm['vs1'] = 500.0
    prm['vdamp'] = 400.0
    prm['gam2'] = 0.8

    # topography
    if surf == 'topo':
        prm['x3'] = [], '=<', 'mesh-z3.bin'

    # boundary conditions
    prm['bc1'] = ['pml', 'pml', 'free']
    prm['bc2'] = ['pml', 'pml', 'pml']

    # source
    mts = os.path.join(cwd, 'run', 'data', '14383980.mts.txt')
    mts = json.load(open(mts))

    # scaling law: fcorner = (dsigma / moment) ^ 1/3 * 0.42 * Vs,
    # dsigma = 4 MPa, Vs = 3900 m/s, tau = 0.5 / (pi * fcorner)
    tau = 6e-7 * mts['moment'] ** (1.0 / 3.0) # ~0.32, fcorner = 0.5Hz

    # hypocenter location at x/y center
    x, y, z = origin
    x, y = proj(x, y)
    x /= abs(dx)
    y /= abs(dy)
    z /= abs(dz)
    if register:
        z = int(z) + 0.5
    hypo = [x, y, z]

    # moment tensor
    m = mts['double_couple_clvd']
    prm['mxx'] = (s_[x,y,z,:], '.',  m['myy'], 'brune', tau)
    prm['myy'] = (s_[x,y,z,:], '.',  m['mxx'], 'brune', tau)
    prm['mzz'] = (s_[x,y,z,:], '.',  m['mzz'], 'brune', tau)
    prm['myz'] = (s_[x,y,z,:], '.', -m['mxz'], 'brune', tau)
    prm['mzx'] = (s_[x,y,z,:], '.', -m['myz'], 'brune', tau)
    prm['mxy'] = (s_[x,y,z,:], '.',  m['mxy'], 'brune', tau)

    # receivers
    sl = os.path.join(cwd, 'run', 'data', 'station-list.txt')
    sl = open(sl).readlines()
    for s in sl:
        s, y, x = s.split()[:3]
        x, y = proj(float(x), float(y))
        x /= dx
        y /= dx
        for f in 'vs', 'v1', 'v2', 'v3':
            if f not in prm:
                prm[f] = []
            prm[f] += [
                (s_[x,y,0.0,:], '=>', 'out/%s-%s.bin' % (s, f)),
            ]

    # surface output
    ns = max(1, np.max([nx, ny, nz]) / 1024)
    nh = 4 * ns
    mh = max(1, int(0.025 / dt + 0.5))
    ms = max(1, int(0.125 / (dt * mh) + 0.5))
    if surf_out:
        for f in 'vx', 'vy', 'vz':
            prm[f] += [
                (s_[::ns,::ns,0,::mh], '=>', 'full-%s.bin' % f),
                (s_[::ns,::ns,0,::ms], '=>', '#snap-%s.bin' % f),
                (s_[::nh,::nh,0,::mh], '=>', '#hist-%s.bin' % f),
            ]

    # cross section output
    if 0:
        j = int(hypo[0] + 0.5)
        k = int(hypo[1] + 0.5)
        for f in 'vx', 'vy', 'vz', 'rho', 'vp', 'vs', 'gam':
            prm[f] += [
                (s_[j,:,:,::ms], '=>', 'xsec-ns-%s.bin' % f),
                (s_[:,k,:,::ms], '=>', 'xsec-ew-%s.bin' % f),
            ]

    # run directory
    path = os.path.join(cwd, 'run', 'sim', name) + os.sep
    os.makedirs(path)
    os.chdir(path)

    # save metadata
    os.link(mesh + 'box.txt', 'box.txt')
    s = '\n'.join([
        open(mesh + 'meta.json').read(),
        '# source parameters',
        json.dumps(mts),
        open('meta.json').read(),
    ])
    open('meta.json', 'w').write(s)

    # save decimated mesh
    if surf_out:
        for f in 'lon.npy', 'lat.npy', 'topo.npy':
            s = np.load(mesh + f)
            np.save(f, s[::ns,::ns])

    # run SORD
    job = cst.sord.run(prm)

    # post-process to compute pgv, pga
    if surf_out:
        meta = open('meta.json')
        meta = json.load(meta)
        x, y, t = meta['shapes']['full-v1.bin']
        m = x * y * t // 60000000
        f = os.path.joing(cwd, 'cook.py')
        shutil.copy2(f, path)
        cst.util.launch(
            name = 'cook',
            execute = '{python} cook.py',
            depend = job['jobid'],
            minutes = m,
        )

