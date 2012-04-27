#!/usr/bin/env ipython --gui=wx -i
import sys, getopt
import cst
opts, faults = getopt.getopt(sys.argv, 's')
split = '-s' in dict(opts)
cst.cfm.explore(faults, split)

