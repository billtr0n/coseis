! setup model dimensions
module setup
implicit none
contains

subroutine setup_dimensions
use globals
use collective
use utilities
integer :: nl(3)
character(32) :: filename

if (sync) call barrier
if (master) print *, clock(), 'Setup dimensions'

! dimensions
dx = delta(1:3)
dt = delta(4)
nn = shape_(1:3)
nt = max(shape_(4), 0)

! fault normal
ifn = abs(faultnormal)

! partition for parallelization
nl3 = (nn - 1) / nproc3 + 1
nhalo = 1
if (ifn /= 0) nhalo(ifn) = 2
nl3 = max(nl3, nhalo)
nproc3 = (nn - 1) / nl3 + 1
call rank(ip, ip3, nproc3)

! master process
master = ip == 0

! offset from local to global indices
nnoff = nl3 * ip3 - nhalo

! process rank for hypocenter 
ip3hypo = floor((ihypo - 1.0) / nl3)

! size of arrays
nl = min(nl3, nn - nnoff - nhalo)
nm = nl + 2 * nhalo

! boundary conditions
i1bc = 1  - nnoff
i2bc = nn - nnoff

! non-overlapping core region
i1core = 1  + nhalo
i2core = nm - nhalo

! node region
i1node = max(i1bc, 2)
i2node = min(i2bc, nm - 1)

! cell region
i1cell = max(i1bc, 1)
i2cell = min(i2bc - 1, nm - 1)

! pml region
i1pml = i1pml - nnoff
i2pml = i2pml - nnoff

! map rupture index to local indices, and test if fault on this process
irup = 0
if (ifn /= 0) then
    irup = floor(ihypo(ifn) + 0.000001) - nnoff(ifn)
    if (irup + 1 < i1core(ifn) .or. irup > i2core(ifn)) ifn = 0
end if

! debugging
sync = debug > 1
if (debug > 2) then
    write (filename, "(a,i6.6,a)") 'debug/db', ip, '.py'
    open (1, file=filename, status='replace')
    write (1, "('ifn     = ', i8)") ifn
    write (1, "('irup    = ', i8)") irup
    write (1, "('ip      = ', i8)") ip
    write (1, "('nproc3  = ', i8, 2(',', i8))") nproc3
    write (1, "('ip3     = ', i8, 2(',', i8))") ip3
    write (1, "('nn      = ', i8, 2(',', i8))") nn
    write (1, "('nm      = ', i8, 2(',', i8))") nm
    write (1, "('bc1     = ', i8, 2(',', i8))") bc1
    write (1, "('bc2     = ', i8, 2(',', i8))") bc2
    write (1, "('nhalo   = ', i8, 2(',', i8))") nhalo
    write (1, "('nnoff   = ', i8, 2(',', i8))") nnoff
    write (1, "('i1bc    = ', i8, 2(',', i8), '; i2bc   = ', i8, 2(',', i8))") i1bc, i2bc
    write (1, "('i1pml   = ', i8, 2(',', i8), '; i2pml  = ', i8, 2(',', i8))") i1pml, i2pml
    write (1, "('i1core  = ', i8, 2(',', i8), '; i2core = ', i8, 2(',', i8))") i1core, i2core
    write (1, "('i1node  = ', i8, 2(',', i8), '; i2node = ', i8, 2(',', i8))") i1node, i2node
    write (1, "('i1cell  = ', i8, 2(',', i8), '; i2cell = ', i8, 2(',', i8))") i1cell, i2cell
    close (1)
end if

end subroutine

end module

