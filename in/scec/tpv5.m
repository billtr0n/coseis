% TPV5
  np       = [    1   1   2 ];
  np       = [    1   1  16 ];
  nn       = [  351 176  64 ];
  n1expand = [    0   0   0 ];
  n2expand = [    0   0   0 ];
  bc1      = [   10   0  10 ];
  bc2      = [   10  10  -2 ];
  ihypo    = [    0  76  -2 ];
  fixhypo  =     -1;
  xhypo    = [   0.  0.  0. ];
  affine   = [ 1. 0. 0.   0. 1. 0.   0. 0. 1. ];
  nt  = 1500;
  dx  = 100.;
  dt  = 0.008;

  rho = 2670.;
  vp  = 6000.;
  vs  = 3464.;
  gam = 0.2;
  gam = { 0.02 'cube' -15001. -7501. -4000.   15001. 7501. 4000. };
  hourglass = [ 1. 2. ];

  faultnormal = 3;
  vrup = -1.;
  dc  = 0.4;
  mud = 0.525;
  mus = 10000.;
  mus = { 0.677   'cube' -15001. -7501. -1.  15001. 7501. 1. };
  tn  = -120e6;
  ts1 = 70e6;
  ts1 = { 72.9e6 'cube'  -1501. -1501. -1.   1501. 1501. 1. };
  ts1 = { 75.8e6 'cube'  -1501. -1499. -1.   1501. 1499. 1. };
  ts1 = { 75.8e6 'cube'  -1499. -1501. -1.   1499. 1501. 1. };
  ts1 = { 81.6e6 'cube'  -1499. -1499. -1.   1499. 1499. 1. };

  ts1 = { 72.0e6 'cube'  -9001. -1501. -1.  -5999. 1501. 1. };
  ts1 = { 74.0e6 'cube'  -9001. -1499. -1.  -5999. 1499. 1. };
  ts1 = { 74.0e6 'cube'  -8999. -1501. -1.  -6001. 1501. 1. };
  ts1 = { 78.0e6 'cube'  -8999. -1499. -1.  -6001. 1499. 1. };

  ts1 = { 68.0e6 'cube'   5999. -1501. -1.   9001. 1501. 1. };
  ts1 = { 66.0e6 'cube'   5999. -1499. -1.   9001. 1499. 1. };
  ts1 = { 66.0e6 'cube'   6001. -1501. -1.   8999. 1501. 1. };
  ts1 = { 62.0e6 'cube'   6001. -1499. -1.   8999. 1499. 1. };

  out = { 'x'    1   1 1 -2  0   -1 -1 -2  0 };
  out = { 'mus'  1   1 1  0  0   -1 -1  0  0 };
  out = { 'trup' 1   1 1  0 -1   -1 -1  0 -1 };

  timeseries = { 'su' -12000. -7500. 0. };
  timeseries = { 'sv' -12000. -7500. 0. };
  timeseries = { 'ts' -12000. -7500. 0. };
  timeseries = { 'su'  -7500. -7500. 0. };
  timeseries = { 'sv'  -7500. -7500. 0. };
  timeseries = { 'ts'  -7500. -7500. 0. };
  timeseries = { 'su'  -4500. -7500. 0. };
  timeseries = { 'sv'  -4500. -7500. 0. };
  timeseries = { 'ts'  -4500. -7500. 0. };
  timeseries = { 'su'      0. -7500. 0. };
  timeseries = { 'sv'      0. -7500. 0. };
  timeseries = { 'ts'      0. -7500. 0. };
  timeseries = { 'su'   4500. -7500. 0. };
  timeseries = { 'sv'   4500. -7500. 0. };
  timeseries = { 'ts'   4500. -7500. 0. };
  timeseries = { 'su'   7500. -7500. 0. };
  timeseries = { 'sv'   7500. -7500. 0. };
  timeseries = { 'ts'   7500. -7500. 0. };
  timeseries = { 'su'  12000. -7500. 0. };
  timeseries = { 'sv'  12000. -7500. 0. };
  timeseries = { 'ts'  12000. -7500. 0. };
  timeseries = { 'su'      0. -4500. 0. };
  timeseries = { 'sv'      0. -4500. 0. };
  timeseries = { 'ts'      0. -4500. 0. };

  timeseries = { 'su' -12000.     0. 0. };
  timeseries = { 'sv' -12000.     0. 0. };
  timeseries = { 'ts' -12000.     0. 0. };
  timeseries = { 'su'  -7500.     0. 0. };
  timeseries = { 'sv'  -7500.     0. 0. };
  timeseries = { 'ts'  -7500.     0. 0. };
  timeseries = { 'su'  -4500.     0. 0. };
  timeseries = { 'sv'  -4500.     0. 0. };
  timeseries = { 'ts'  -4500.     0. 0. };
  timeseries = { 'su'      0.     0. 0. };
  timeseries = { 'sv'      0.     0. 0. };
  timeseries = { 'ts'      0.     0. 0. };
  timeseries = { 'su'   4500.     0. 0. };
  timeseries = { 'sv'   4500.     0. 0. };
  timeseries = { 'ts'   4500.     0. 0. };
  timeseries = { 'su'   7500.     0. 0. };
  timeseries = { 'sv'   7500.     0. 0. };
  timeseries = { 'ts'   7500.     0. 0. };
  timeseries = { 'su'  12000.     0. 0. };
  timeseries = { 'sv'  12000.     0. 0. };
  timeseries = { 'ts'  12000.     0. 0. };
  timeseries = { 'su'      0.  4500. 0. };
  timeseries = { 'sv'      0.  4500. 0. };
  timeseries = { 'ts'      0.  4500. 0. };

  timeseries = { 'u'  -12000. -7500. -3000. };
  timeseries = { 'v'  -12000. -7500. -3000. };
  timeseries = { 'u'   12000. -7500. -3000. };
  timeseries = { 'v'   12000. -7500. -3000. };
  timeseries = { 'u'  -12000.     0. -3000. };
  timeseries = { 'v'  -12000.     0. -3000. };
  timeseries = { 'u'   12000.     0. -3000. };
  timeseries = { 'v'   12000.     0. -3000. };
