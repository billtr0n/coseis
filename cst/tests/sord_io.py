#!/usr/bin/env python

def test(**kwargs):
    """
    Test SORD parallelization with point source
    """
    import os
    import numpy as np
    import cst
    prm = {}

    # parameters
    prm['itstats'] = 1
    prm['faultnormal'] = 1
    prm['shape'] = [6, 7, 8, 9]

    # output
    fns = cst.sord.fieldnames()
    x1 = [1.1, 1.1, 1.1]
    x2 = [9.9, 9.9, 9.9]
    ii = [4.4, 5.5, 6.6, 1]
    infiles = []

    for k, v in fns.items():
        if v[0][0] in 'nc':
            prm[k] = []
    for k in 'ax', 'wxx':
        prm[k] += [([], '#')]
        for op in ['=', '+', '*', '=~', '+~', '*~']:
            prm[k] += [([], op, 2.2)]
        for op in ['=@', '+@', '*@']:
            prm[k] += [([], op, x1, x2, 2.2)]
        for func in cst.sord.tfuncs:
            prm[k] += [([], '=', 2.2, func, 3.3)]
        prm[k] += [(ii, '.', 2.2)]
        for i, op in enumerate(['.<', '=<', '+<', '*<']):
            f = 'io/%s_i%s.bin' % (k, i)
            infiles.append(f)
            prm[k] += [(ii, op, f)]

    for k, v in fns.items():
        if v[0][0] in 'nc':
            ii = [4.4, 5.5, 6.6, 1]
            if '<' in v[0]:
                ii = ii[:3]
            prm[k] += [
                (ii, '.>', 'io/%s_o1.bin' % k),
                (ii, '=>', 'io/%s_o0.bin' % k),
            ]

    cwd = os.getcwd()
    d = os.path.join('run', 'sord_io') + os.sep
    os.makedirs(d + 'io')
    os.chdir(d)
    for f in infiles:
        np.array([1.0], 'f').tofile(f)
    cst.sord.run(prm, **kwargs)
    os.chdir(cwd)

# continue if command line
if __name__ == '__main__':
    test()

