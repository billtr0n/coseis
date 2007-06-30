% Kostrov constant rupture velocity test

  np = [ 1 1 1 ];
  nt = 400;
  nn = [ 121 121 42 ];
  bc1 = [ 11 11 11 ];
  bc2 = [ 11 11 11 ];
  faultnormal = 3;
  mus = 1e9;
  mud = 0.;
  dc = 1e9;
  co = 0.;
  tn = -100e6;
  ts1 = -90e6;
  vrup = 3117.6914;
  rcrit = 1e9;
  trelax = 0.;
  out = { 'x'    1  1 1 0  0   -1 -1  0  0 };
  out = { 'sl'   1  1 1 0  1   -1 -1  0 -1 };
  out = { 'svm'  1  1 1 0  1   -1 -1  0 -1 };
  out = { 'v'   20  1 1 1 20   -1 -1 -1 -1 };
