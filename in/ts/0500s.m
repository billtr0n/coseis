% TeraShake 500 m - surface output
% np(3) = 1:15, 17, 18, 21, 23, 27, 33, 41, 54, 81, 161
  datadir = 'ts/0500/data'; itio = 400; itcheck = 0;
  nt = 6000;
  np = [ 1 1 82 ];
  np = [ 1 1 54 ];
  np = [ 1 1 18 ];


  grid  = 'read';
  rho   = 'read';
  vp    = 'read'; vp1  = 1500.;
  vs    = 'read'; vs1  = 500.;
  vdamp = 400.;   gam2 = .8;
  bc1   = [ 10 10 10 ];
  bc2   = [ 10 10  0 ];
  fixhypo = 1; faultnormal = 2; slipvector = [ 1. 0. 0. ];
  mus = 1000.;
  mud = .5;
  dc  = .5;
  tn  = -20e6;
  ts1 = 'read';
  rcrit = 3000.; vrup = 2300.;

  dx = 500.; dt = .03; trelax = .3;
  nn    = [ 1201  602 161 ];
  ihypo = [  545  399 -11 ];
  ihypo = [  907  399 -11 ];
  mus = [ 1.09 'zone'   527   0 -33         925   0 -1      ];
% out = { 'x'      1    527 399 -33    0    925 399 -1    0 };
% out = { 'rho'    1    527   0 -33    0    925   0 -1    0 };
% out = { 'vp'     1    527   0 -33    0    925   0 -1    0 };
% out = { 'vs'     1    527   0 -33    0    925   0 -1    0 };
% out = { 'gam'    1    527   0 -33    0    925   0 -1    0 };
% out = { 'gamt'   1    527   0 -33    0    925   0 -1    0 };
% out = { 'tn'    10    527   0 -33    0    925   0 -1 3000 };
% out = { 'tsm'   10    527   0 -33    0    925   0 -1 3000 };
% out = { 'sl'    10    527   0 -33    0    925   0 -1 3000 };
% out = { 'svm'   10    527   0 -33    0    925   0 -1 3000 };
% out = { 'psv'   10    527   0 -33    0    925   0 -1 3000 };
% out = { 'trup'   1    527   0 -33 3000    925   0 -1 3000 };
% return
  out = { 'x'      1      1   1  -1    0     -1  -1 -1    0 };
  out = { 'rho'    1      1   1  -2    0     -1  -1 -1    0 };
  out = { 'vp'     1      1   1  -2    0     -1  -1 -1    0 };
  out = { 'vs'     1      1   1  -2    0     -1  -1 -1    0 };
  out = { 'pv2'   20      1   1  -1    0     -1  -1 -1   -1 };
  out = { 'vm2'   20      1   1  -1    0     -1  -1 -1   -1 };
  out = { 'v' 1    164  387 -1 0    164  387 -1 -1 }; % Bakersfield
  out = { 'v' 1    200  139 -1 0    200  139 -1 -1 }; % Santa Barbara
  out = { 'v' 1    305  163 -1 0    305  163 -1 -1 }; % Oxnard
  out = { 'v' 1    381  385 -1 0    381  385 -1 -1 }; % Lancaster
  out = { 'v' 1    432  236 -1 0    432  236 -1 -1 }; % Westwood
  out = { 'v' 1    457  257 -1 0    457  257 -1 -1 }; % Los Angeles
  out = { 'v' 1    483  268 -1 0    483  268 -1 -1 }; % Montebello
  out = { 'v' 1    505  213 -1 0    505  213 -1 -1 }; % Long Beach
  out = { 'v' 1    512  537 -1 0    512  537 -1 -1 }; % Barstow
  out = { 'v' 1    523  457 -1 0    523  457 -1 -1 }; % Victorville
  out = { 'v' 1    538  336 -1 0    538  336 -1 -1 }; % Ontario
  out = { 'v' 1    554  248 -1 0    554  248 -1 -1 }; % Santa Ana
  out = { 'v' 1    583  384 -1 0    583  384 -1 -1 }; % San Bernardino
  out = { 'v' 1    591  341 -1 0    591  341 -1 -1 }; % Riverside
  out = { 'v' 1    705  188 -1 0    705  188 -1 -1 }; % Oceanside
  out = { 'v' 1    737  376 -1 0    737  376 -1 -1 }; % Palm Springs
  out = { 'v' 1    812  392 -1 0    812  392 -1 -1 }; % Coachella
  out = { 'v' 1    806  131 -1 0    806  131 -1 -1 }; % San Diego
  out = { 'v' 1   1005   61 -1 0   1005   61 -1 -1 }; % Ensenada
  out = { 'v' 1   1057  326 -1 0   1057  326 -1 -1 }; % Mexicali
  out = { 'v' 1   1164  450 -1 0   1164  450 -1 -1 }; % Yuma
