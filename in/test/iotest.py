# I/O test
nt = 10
nn = ( 50, 50, 50 )
np = ( 4, 4, 2 )
mpin  = 1
mpout = 1
faultnormal = 3
io = [
  ( 'wi', ('u1','u2','u3'), (1,1,1,0), (1, -1,-1,-1), (1,1,1,1), 1 ),
  ( 'wi', ('v1','v2','v3'), (1,1,1,0), (-1, 1,-1,-1), (1,1,1,1), 1 ),
  ( 'wi', ('a1','a2','a3'), (1,1,1,0), (-1,-1, 1,-1), (1,1,1,1), 1 ),
  ( 'w*', ('su1','su2','su3','sv1','sv2','sv3','sa1','sa2','sa3'), 1 ),
]
