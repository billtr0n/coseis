#!/usr/bin/env python
"""
Default configuration
"""
import os, pwd
import numpy as np

name = 'default'
rundir = 'run'
mode = 's'
bin = 'date'
pre = post = ''
walltime = '1:00:00'
email = user = pwd.getpwuid( os.geteuid() )[0]
nproc = 1
totalcores = 1
nodes = 1
ppn = 1
dtype = np.dtype( 'f' ).str

