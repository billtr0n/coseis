#!/usr/bin/env python
"""
Simple SoCal mesh generation and CVM extraction.
"""
import os, cvm
import numpy as np

# parameters
workdir = 'run'
delta = 0.25 / 60.0, 0.25 / 60.0, 20.0;   nproc = 512
delta = 1.0  / 60.0, 1.0  / 60.0, 1000.0; nproc = 1
extent = (-120.5, -112.5), (31.0, 36.0), (0.0, 11000.0)

# node locations
x, y, z = extent
dx, dy, dz = delta
x = np.arange( x[0], x[1] + dx/2, dx, 'f' )
y = np.arange( y[0], y[1] + dy/2, dy, 'f' )
z = np.arange( z[0], z[1] + dz/2, dz, 'f' )
shape = x.size, y.size, z.size

# 2d mesh
x, y = np.meshgrid( x, y )

# metadata
meta = dict(
    delta = delta,
    shape = shape,
    extent = extent,
    dtype = np.dtype( 'f' ).str,
)

# continue if run from the command line
if __name__ == '__main__':

    # save data
    path = 'data' + os.sep
    cvm.util.save( path + 'meta.py', meta )
    x.tofile( path + 'lon' )
    y.tofile( path + 'lat' )

    # CVM setup
    print 'shape = %s' % (shape,)
    n = shape[0] * shape[1] * shape[2]
    job = cvm.stage( nsample=n, nproc=nproc, workdir=workdir )
    path = job.rundir + os.sep

    # write CVM input files
    f1 = open( path + 'lon', 'wb' )
    f2 = open( path + 'lat', 'wb' )
    f3 = open( path + 'dep', 'wb' )
    for i in range( z.size ):
        x.tofile( f1 )
        y.tofile( f2 )
    for i in range( z.size ):
        x.fill( z[i] )
        x.tofile( f3 )
    f1.close()
    f2.close()
    f3.close()

    # launch
    cvm.launch( job )
