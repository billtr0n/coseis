#!/usr/bin/env python
import numpy as np
import matplotlib.pyplot as plt
import cvm

path = 'data/'
meta = cvm.util.load( path + 'meta.py' )
shape = meta.shape
extent = meta.extent
lon, lat = extent[:2]
aspect = 1.0 / np.cos( np.mean(lat) / 180.0 * np.pi )
n = shape[:2]
z = np.fromfile( path + 'z25', 'f' ).reshape( n[::-1] )

fig = plt.figure()
ax = fig.add_subplot( 111 )
im = ax.imshow( z, origin='lower', extent=lon+lat )
im.set_clim( 0.0, 8000.0 )
ax.set_aspect( aspect )
ax.axis( lon+lat )
fig.savefig( path + 'z25.png' )
fig.show()
