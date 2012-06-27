"""
TACC Ranger: Sun Constellation

.bashrc:
export PATH=/share/home/00967/gely/local/python/bin:${PATH}
export PATH=${HOME}/coseis/bin:${PATH}
export PYTHONPATH=${HOME}/coseis

.profile_user:
module unload mvapich pgi
module load intel mvapich
module load git
"""

# machine properties
maxcores = 16
maxram = 32768
rate = 12e5
queue_opts = [
    ('development', {'maxnodes': 16,   'maxtime':  120}),
    ('normal',      {'maxnodes': 256,  'maxtime': 1440}),
    ('large',       {'maxnodes': 1024, 'maxtime': 1440}),
    ('long',        {'maxnodes': 256,  'maxtime': 2880}),
    ('serial',      {'maxnodes': 1,    'maxtime':  120}),
    ('vis',         {'maxnodes': 2,    'maxtime': 1440}),
    ('request', {}),
]

# MPI
build_ldflags = '-warn -O2 -xW'
ppn_range = [1, 2, 4, 8, 12, 15, 16]
nthread = 1

# MPI + OpenMP
build_ldflags = '-warn -O2 -xW -openmp -g -CB -traceback'
build_ldflags = '-warn -O2 -xW -openmp -g -pg'
build_ldflags = '-warn -O2 -xW -openmp'
ppn_range = [1]
nthread = 16

# compilers
build_cc = 'mpicc'
build_fc = 'mpif90'
build_ld = 'mpif90'
build_cflags = build_ldflags
build_fflags = build_ldflags + ' -u -std03 -r8'
build_fflags = build_ldflags + ' -u -std03'
f2py_flags = '--fcompiler=intelem'

# job submission
launch = 'ibrun -n {nproc} -o 0 {command}'
launch = 'ibrun {command}'
notify = '-m abe'
submit = 'qsub {notify} {submit_flags} "{code}.sh"'
submit2 = 'qsub {notify} -hold_jid "{depend}" {submit_flags} "{code}.sh"'

