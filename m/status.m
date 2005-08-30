%------------------------------------------------------------------------------%
% OUTPUT

if init
  init = 0;
  fprintf( 'Initialize output\n' )
  s1(:) = 0.;
  s2(:) = 0.;
  w1(:) = 0.;
  w2(:) = 0.;
  if checkpoint < 0, checkpoint = nt + checkpoint + 1; end
  if ~readcheckpoint
    if exist( 'out', 'dir' ), rmdir( 'out', 's' ), end
    mkdir( 'out/stats/' )
  else
    % FIXME read checkpoint
  end
  [ tmp1, tmp2, endian ] = computer;
  fid = fopen( 'out/endian', 'w' );
  fprintf( fid, '%s\n', endian );
  fclose( fid );
  fid = fopen( 'out/xhypo', 'w' );
  fprintf( fid, '%g %g %g\n', xhypo );
  fclose( fid );
  outinit = ones( size( outit ) );
  fprintf( 'Step  Vmax          Vslipmax      WallTime\n' )
  tic
  return
end

for iz = 1:size( outit, 1 )
  if outit(iz) < 0, outit(iz) = outit(iz) + nt + 1; end
  if ~outit(iz) | mod( it, outit(iz) ), continue, end
  nc = 1;
  onpass = 'v';
  cell = 0;
  isfault = 0;
  static = 0;
  switch outvar{iz}
  case '|a|'
  case '|v|'
  case 'a',   nc = 3;
  case 'v',   nc = 3;
  case '|u|', onpass = 'w';
  case '|w|', onpass = 'w'; cell = 1;
  case 'u',   onpass = 'w'; nc = 3;
  case 'w',   onpass = 'w'; nc = 6; cell = 1;
  case 'x',   static = 1; nc = 3;
  case 'rho', static = 1;
  case 'yn',  static = 1;
  case 'lam', static = 1; cell = 1;
  case 'miu', static = 1; cell = 1;
  case 'yc',  static = 1; cell = 1;
  case 'vslip', isfault = 1;
  case 'uslip', isfault = 1;
  case 'trup',  isfault = 1;
  otherwise error output
  end
  if isfault & ~nrmdim; outit(iz) = 0; end
  if onpass ~= pass, continue, end
  if outinit(iz)
    outinit(iz) = 0;
    for i = 1:nc
      file = sprintf( 'out/%02d/%1d/', iz, i );
      mkdir( file )
    end
  end
  [ i1, i2 ] = zoneselect( iout(iz,:), nn, offset, hypocenter, nrmdim );
  if cell; i2 = i2 - 1; end
  if isfault
    i1(nrmdim) = 1;
    i2(nrmdim) = 1;
  end
  l = i1(3):i2(3);
  k = i1(2):i2(2);
  j = i1(1):i2(1);
  for i = 1:nc
    file = sprintf( 'out/%02d/%1d/%05d', iz, i, it );
    fid = fopen( file, 'wl' );
    switch outvar{iz}
    case '|a|',   fwrite( fid, s1(j,k,l),         'float32' );
    case '|v|',   fwrite( fid, s2(j,k,l),         'float32' );
    case 'a',     fwrite( fid, w1(j,k,l,i) / dt,  'float32' );
    case 'v',     fwrite( fid, v(j,k,l,i),        'float32' );
    case '|u|',   fwrite( fid, s1(j,k,l),         'float32' );
    case '|w|',   fwrite( fid, s2(j,k,l),         'float32' );
    case 'u',     fwrite( fid, u(j,k,l,i),        'float32' );            
    case 'w'
      if i < 4,   fwrite( fid, w1(j,k,l,i),       'float32' ); end
      if i > 3,   fwrite( fid, w2(j,k,l,i-3),     'float32' ); end
    case 'x',     fwrite( fid, x(j,k,l,i),        'float32' );
    case 'rho',   fwrite( fid, rho(j,k,l),        'float32' );
    case 'yn',    fwrite( fid, yn(j,k,l),         'float32' );
    case 'lam',   fwrite( fid, lam(j,k,l),        'float32' );
    case 'miu',   fwrite( fid, miu(j,k,l),        'float32' );
    case 'yc',    fwrite( fid, yc(j,k,l),         'float32' );
    case 'vslip', fwrite( fid, vslip(j,k,l),      'float32' );
    case 'uslip', fwrite( fid, uslip(j,k,l),      'float32' );
    case 'trup',  fwrite( fid, trup(j,k,l),       'float32' );
    otherwise error outvar
    end
    fclose( fid );
    if static, outit(iz) = 0; end
  end
  file = sprintf( 'out/%02d/hdr', iz );
  fid = fopen( file, 'w' );
  fprintf( fid, '%g ', [ nc i1-offset i2-offset outit(iz) it dt dx ] );
  fprintf( fid, '%s\n', outvar{iz} );
  fclose( fid );
end

if pass == 'w', return, end

if checkpoint & ~mod( it, checkpoint )
  save checkpoint it v u vslip uslip trup
end

fid = fopen( 'out/timestep', 'w' );
fprintf( fid, '%g\n', it );
fclose( fid );

file = sprintf( 'out/stats/%05d', it );
fid = fopen( file, 'w' );
fmt = '%13.6e %13.6e %13.6e %13.6e %13.6e %13.6e %9.2e %9.2e %9.2e %9.2e %9.2e\n';
fprintf( fid, fmt, [ amax vmax umax wmax vslipmax uslipmax sum( wt ) wt ] );
fclose( fid );

fmt = '%4d %13.6e %13.6e %9.2e\n';
fprintf( fmt, [ it vmax vslipmax sum( wt ) ] );

