% Test

  nt = 0;
  debug = 3;
  faultnormal = 2;
  np = [ 2 2 3 ];
  np = [ 1 3 4 ];
  nn = [ 3 6 3 ];
  ihypo = [ 2 2 2 ];
gridnoise = -0.1;
gridnoise = 0.1;

return

% affine = [ 1. 0. 1.   1. 1. 0.   0. 0. 1.   1. ];
% n1expand = [ 2 2 2 ];
% n2expand = [ 2 2 2 ];

  out = { 'x'   1  1 1 1 1   -1 -1 -1 -1 };

  out = { 'rho' 1  1 1 1 1   -1 -1 -1 -1 };
  out = { 'vp'  1  1 1 1 1   -1 -1 -1 -1 };
  out = { 'vs'  1  1 1 1 1   -1 -1 -1 -1 };
  out = { 'gam' 1  1 1 1 1   -1 -1 -1 -1 };

  out = { 'u'   1  1 1 1 1   -1 -1 -1 -1 };
  out = { 'v'   1  1 1 1 1   -1 -1 -1 -1 };
  out = { 'a'   1  1 1 1 1   -1 -1 -1 -1 };

  out = { 'su'  1  1 1 1 0   -1 -1 -1 -1 };
  out = { 'sv'  1  1 1 1 0   -1 -1 -1 -1 };
  out = { 'sa'  1  1 1 1 1   -1 -1 -1 -1 };

