%------------------------------------------------------------------------------%
% CROSSHAIRS

way = sign( xhairmove );
xhairmove = abs( xhairmove );
nc = ncore - cellfocus;
if xhairmove == 4
  xhair = hypocenter - halo1;
  if nrmdim
    slicedim = nrmdim;
    if cellfocus, xhair(nrmdim) = xhair(nrmdim) + 1; end
  end
elseif xhairmove == 5
  xhair = hypocenter - halo1;
  xhair(downdim) = 1;
  slicedim = downdim;
  if nrmdim && cellfocus
    xhair(nrmdim) = xhair(nrmdim) + 1;
  end
else
  v1 = camup;
  v3 = camtarget - campos;
  v2 = cross( v3, v1 );
  [ t, i1 ] = max( abs( v1 ) );
  [ t, i2 ] = max( abs( v2 ) );
  i3 = 1:3;
  i3( [ i1 i2 ] ) = [];
  i = [ i1 i2 i3 ];
  tmp = [ sign( v1(i1) ) sign( v2(i2) ) sign( v3(i3) ) ];
  way = way * tmp(xhairmove);
  xhairmove = i(xhairmove);
  i = abs( xhairmove );
  if length( hhud )
    xhair(i) = xhair(i) + way;
    if cellfocus && nrmdim == i && xhair(i) == hypocenter(i) - halo1(i)
      xhair(i) = xhair(i) + way;
    end
    if xhair(i) > nc(i), xhair(i) = nc(i);
    elseif xhair(i) < 1, xhair(i) = 1;
    end
  end
  slicedim = i;
end
delete( [ hhud hhelp ] )
hhelp = [];
j = xhair(1) + halo1(1);
k = xhair(2) + halo1(2);
l = xhair(3) + halo1(3);
clear xg xga mga vga
if cellfocus
  for i = 1:3
    xg(i) = 0.125 * ( ...
      x(j,k,l,i) + x(j+1,k+1,l+1,i) + ...
      x(j+1,k,l,i) + x(j,k+1,l+1,i) + ...
      x(j,k+1,l,i) + x(j+1,k,l+1,i) + ...
      x(j,k,l+1,i) + x(j+1,k+1,l,i) );
    xga(i) = xg(i) + 0.125 * xscl * ( ...
      u(j,k,l,i) + u(j+1,k+1,l+1,i) + ...
      u(j+1,k,l,i) + u(j,k+1,l+1,i) + ...
      u(j,k+1,l,i) + u(j+1,k,l+1,i) + ...
      u(j,k,l+1,i) + u(j+1,k+1,l,i) );
  end
else
  xg(1:3) = x(j,k,l,:);
  xga(1:3) = x(j,k,l,:) + xscl * u(j,k,l,:);
end
xhairtarg = double( xga(:)' );
switch field
case 'u'
  vga(1:3) = u(j,k,l,:);
  mga = sum( u(j,k,l,:) .* u(j,k,l,:), 4 );
  tmp = [ sqrt( mga ) vga ];
  msg = sprintf( '|U|%9.2e\nUx %9.2e\nUy %9.2e\nUz %9.2e', tmp );
case 'v'
  vga(1:3) = v(j,k,l,:);
  mga = s1(j,k,l);
  tmp = [ sqrt( mga ) vga ];
  msg = sprintf( '|V|%9.2e\nVx %9.2e\nVy %9.2e\nVz %9.2e', tmp );
case 'w'
  c = [ 1 6 5; 6 2 4; 5 4 3 ];
  clear wg
  wg(1:3) = w1(j,k,l,:);
  wg(4:6) = w2(j,k,l,:);
  [ vec, val ] = eig( wg(c) );
  val = diag( val );
  [ tmp, i ] = sort( abs( val ) );
  val = val(i);
  vec = vec(:,i);
  mga = val';
  vga = vec(:)';
  tmp = [ sqrt( s2(j,k,l) ) val(3) wg ];
  msg = sprintf( '|W|f%9.2e\n|W| %9.2e\nWxx %9.2e\nWyy %9.2e\nWzz %9.2e\nWyz %9.2e\nWzx %9.2e\nWxy %9.2e', tmp );
end
set( gcf, 'CurrentAxes', haxes(2) )
hhud = text( .02, .98, msg, 'Hor', 'left', 'Ver', 'top' );
tmp = [ it j k l; it * dt xg ];
msg = sprintf( '%4d %8.3fs\n%4d %8.1fm\n%4d %8.1fm\n%4d %8.1fm', tmp );
hhud(2) = text( .98, .98, msg, 'Hor', 'right', 'Ver', 'top' );
msg = '';
set( gcf, 'CurrentAxes', haxes(1) )
if length( mga( mga ~= 0 ) )
  if doglyph, reynoldsglyph, else, wireglyph, end
  hhud = [ hhud hglyph ];
end
if dooutline
  points = [ halo1 + 1 halo1 + ncore ];
  points(slicedim)   = xhair(slicedim) + halo1(slicedim);
  points(slicedim+3) = xhair(slicedim) + halo1(slicedim) + cellfocus;
  if nrmdim & slicedim ~= nrmdim
    points = [ points; points ];
    points(1,nrmdim+3) = hypocenter(nrmdim);
    points(2,nrmdim)   = hypocenter(nrmdim)+1;
  end
  for iz = 1 : size( points, 1 )
    i1 = points(iz,1:3);
    i2 = points(iz,4:6);
    i  = [ i1; i1+1; i2; i2-1 ];
    if cellfocus
      i1 = [ 1 1 2 2; 1 1 2 2; 1 1 2 2; 1 1 2 2;
             1 1 2 2; 1 1 2 2; 1 1 2 2; 1 1 2 2 ];
      i2 = [ 1 1 1 1; 1 1 1 1; 3 3 3 3; 3 3 3 3;
             2 1 1 2; 4 3 3 4; 2 1 1 2; 4 3 3 4 ];
      i3 = [ 2 1 1 2; 4 3 3 4; 2 1 1 2; 4 3 3 4;
             1 1 1 1; 1 1 1 1; 3 3 3 3; 3 3 3 3 ];
    else
      i1 = [ 1 1 1; 1 1 1; 1 1 1; 1 1 1 ];
      i2 = [ 1 1 2; 1 1 2; 3 3 4; 3 3 4 ];
      i3 = [ 2 1 1; 4 3 3; 2 1 1; 4 3 3 ];
    end
    switch slicedim
    case 1, j = i(i1); k = i(i2+4); l = i(i3+8);
    case 2, j = i(i3); k = i(i1+4); l = i(i2+8);
    case 3, j = i(i2); k = i(i3+4); l = i(i1+8);
    end
    ii = sub2ind( n(1:3), j, k, l )';
    ng = prod( n(1:3) );
    clear xg
    for i = 0:2
      xg(:,:,i+1) = x(ii+i*ng) + xscl * u(ii+i*ng);
    end
    xg(end+1,:,:) = NaN;
    ng = size( xg );
    xg = reshape( xg, [ prod( ng(1:2) ) 3 ] );
    xga = xg;
  end
  hhud(end+1) = plot3( xg(:,1), xg(:,2), xg(:,3), 'Tag', 'outline' );
end
i1 = xhair + halo1;
i = [ i1-1; i1; i1+1 ];
if cellfocus
  i1 = [ 2 2 3 3; 2 2 3 3; 2 2 3 3; 2 2 3 3 ];
  i2 = [ 2 2 2 2; 3 3 3 3; 3 2 2 3; 2 3 3 2 ];
  i3 = [ 2 3 3 2; 3 2 2 3; 2 2 2 2; 3 3 3 3 ];
  il = [ 4 11 2 ];
else
  i1 = [ 1 2 3; 2 2 2; 2 2 2 ];
  i2 = [ 2 2 2; 1 2 3; 2 2 2 ];
  i3 = [ 2 2 2; 2 2 2; 1 2 3 ];
  il = [ 3 7 11 ];
end
j = i(i1);
k = i(i2+3);
l = i(i3+6);
ii = sub2ind( n(1:3), j, k, l )';
ng = prod( n(1:3) );
clear xg
for i = 0:2
  xg(:,:,i+1) = x(ii+i*ng) + xscl * u(ii+i*ng);
end
xg(end+1,:,:) = NaN;
ng = size( xg );
xg = reshape( xg, [ prod( ng(1:2) ) 3 ] );
hhud(end+1) = plot3( xg(:,1), xg(:,2), xg(:,3) );
xg = double( xg(il,:) );
hhud(end+1:end+3) = text( xg(:,1), xg(:,2), xg(:,3), ['123']', 'Ver', 'middle');
if showframe ~= nframe
  showframe = nframe;
  set( [ frame{:} ], 'Visible', 'off' )
  set( [ frame{showframe} ], 'Visible', 'on' )
end

