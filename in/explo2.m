% Explosion test problem
  np = [ 1 2 1 ];
  nn = [ 101 101 61 ];
  dx = 100.;
  dt = .008;
  nt = 200;
  vp  = 6000.;
  vs  = 3464.;
  rho = 2700.;
  gam = .2;
  hourglass = [ 1. 3. ];
  rexpand = 1.06;
  n1expand = [ 20 20 20 ];
  n2expand = [ 20 20 20 ];
  bc1 = [ 0 0 0 ];
  bc2 = [ 0 0 0 ];
  faultnormal = 0;
  ihypo = [ 31 31 31 ];
  xhypo = [ 0. 0. 0. ];
  fixhypo = -1; rsource = 100.;
  fixhypo = -2; rsource = 50.;
  moment1 = [ 1e18 1e18 1e18 ];
  moment2 = [ 0 0 0 ];
  tfunc = 'brune';
  tsource = .1;
  timeseries = { 'v'    0. 4000. 0. };
  timeseries = { 'x'    0. 4000. 0. };
  timeseries = { 'v' 3000. 4000. 0. };
  timeseries = { 'x' 3000. 4000. 0. };
  timeseries = { 'v' 4000. 4000. 0. };
  timeseries = { 'x' 4000. 4000. 0. };

