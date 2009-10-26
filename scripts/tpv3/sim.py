#!/usr/bin/env python
"""
TPV3 - SCEC validation problem version 3, convergence test
"""
import sord

debug = 0
run_ = [ 
    500.0, (1, 1, 2),
    300.0, (1, 1, 2),
    250.0, (1, 1, 2),
    150.0, (1, 1, 2),
    100.0, (1, 1, 2),
]
run_ = [ 
    500.0, (1, 4, 4),
    300.0, (1, 4, 4),
    250.0, (1, 4, 4),
    150.0, (1, 4, 4),
    100.0, (1, 4, 4),
    75.0,  (1, 4, 4),
    50.0,  (1, 4, 8),
    30.0,  (1, 8, 8),
    25.0,  (1, 8, 16),
    15.0,  (1, 16, 16),
    10.0,  (4, 16, 16),
]
run_ = [ 50.0, (1, 1, 2), ]
run_ = [ 150.0, (1, 1, 2), ]
run_ = [ 300.0, (1, 1, 2), ]
faultnormal = 3	
hourglass = 1.0, 2.0

for i in range( 0, len( run_ ), 2 ):
    np3 = run_[i+1]
    dx = 3 * [ run_[i] ]
    dt = dx[0] / 12500.0
    nt = int( 12.0 / dt + 1.5 )
    nn = ( 
        int( 16500.0 / dx[0] + 21.5 ),
        int(  9000.0 / dx[1] + 21.5 ),
        int(  6000.0 / dx[2] + 20.5 ),
    )
    bc1     = 10, 10, 10
    bc2     = -1,  1, -2
    ihypo   = -1, -1, -1.5

    j, k, l = -1, -1, -2
    jj_ = -int( 15000.0 / dx[0] + 1.5 ), -1
    kk_ = -int(  7500.0 / dx[1] + 1.5 ), -1
    ll_ = -int(  3000.0 / dx[2] + 1.5 ), -1
    oo_ = -int(  1500.0 / dx[0] + 1.5 ), -1
    xx_ = -int(  1500.0 / dx[0] + 0.5 ), -1

    fieldio = [
        ( '=',  'rho',  [],               2670.0    ),
        ( '=',  'vp',   [],               6000.0    ),
        ( '=',  'vs',   [],               3464.0    ),
        ( '=',  'gam',  [],               0.2       ),
        ( '=',  'dc',   [],               0.4       ),
        ( '=',  'mud',  [],               0.525     ),
        ( '=',  'mus',  [],               1e4       ),
        ( '=',  'tn',   [],              -120e6     ),
        ( '=',  'ts',   [],                70e6     ),
        ( '=',  'gam',  [jj_, kk_, ll_, ()],  0.02       ),
        ( '=',  'mus',  [jj_, kk_, l,   ()],  0.677      ),
        ( '=',  'ts',   [oo_, oo_, l,   ()],  72.9e6     ),
        ( '=',  'ts',   [xx_, oo_, l,   ()],  75.8e6     ),
        ( '=',  'ts',   [oo_, xx_, l,   ()],  75.8e6     ),
        ( '=',  'ts',   [xx_, xx_, l,   ()],  81.6e6     ),
        ( '=w', 'x1',   [jj_, kk_, l,   ()], 'flt-x1'    ),
        ( '=w', 'x2',   [jj_, kk_, l,   ()], 'flt-x2'    ),
        ( '=w', 'tsm',  [jj_, kk_, l,   -1], 'flt-tsm'   ),
        ( '=w', 'su1',  [jj_, kk_, l,   -1], 'flt-su1'   ),
        ( '=w', 'su2',  [jj_, kk_, l,   -1], 'flt-su2'   ),
        ( '=w', 'psv',  [jj_, kk_, l,   -1], 'flt-psv'   ),
        ( '=w', 'trup', [jj_, kk_, l,   -1], 'flt-trup'  ),
       #( '=w', 'tsm',  [jj_, kk_, l,    1], 'flt-tsm0'  ),
       #( '=w', 'tnm',  [jj_, k,   l,   ()], 'xt-tnm'    ),
       #( '=w', 'tsm',  [jj_, k,   l,   ()], 'xt-tsm'    ),
       #( '=w', 'sam',  [jj_, k,   l,   ()], 'xt-sam'    ),
       #( '=w', 'svm',  [jj_, k,   l,   ()], 'xt-svm'    ),
       #( '=w', 'sl',   [jj_, k,   l,   ()], 'xt-sl'     ),
       #( '=w', 'vm2',  [0,   k,   0, (1, -1, 10)], 'xh' ),
       #( '=w', 'vm2',  [j,   0,   0, (1, -1, 10)], 'xv' ),
       #( '=c', 'gam',  [], 0.02  (-15001., -7501., -4500.), (15001., 7501., 4500.) ),
       #( '=c', 'mus',  [], 0.677 (-15001., -7501.,    -1.), (15001., 7501.,    1.) ),
       #( '=c', 'ts',   [], 72.9e6 (-1501., -1501.,    -1.), (1501.,  1501.,    1.) ),
       #( '=c', 'ts',   [], 75.8e6 (-1501., -1499.,    -1.), (1501.,  1499.,    1.) ),
       #( '=c', 'ts',   [], 75.8e6 (-1499., -1501.,    -1.), (1499.,  1501.,    1.) ),
       #( '=c', 'ts',   [], 81.6e6 (-1499., -1499.,    -1.), (1499.,  1499.,    1.) ),
    ]

    for sta_, x, y in (
        ( 'P1a-', -7499.0,  -1.0 ),
        ( 'P1b-', -7451.0, -49.0 ),
        ( 'P2a-',  -1.0, -5999.0 ),
        ( 'P2b-', -49.0, -5951.0 ),
    ):
        j = ihypo[0] + x / dx[0]
        k = ihypo[1] + y / dx[1]
        l = ihypo[2]
        for f in 'su1', 'su2', 'sv1', 'sv2', 'ts1', 'ts2':
            fieldio += [ ( '=w', f, [j,k,l,()], sta_ + f ) ]

    rundir = '~/run/tpv3-%03.0f' % dx[0]
    sord.run( locals() )

