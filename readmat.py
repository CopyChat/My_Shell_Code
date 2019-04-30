#!/usr/bin/env python
import sys 
import math
import numpy as np
import matplotlib as mpl
import matplotlib.pyplot as plt
import argparse

# to load my functions
sys.path.append('/Users/ctang/Microsoft_OneDrive/OneDrive/CODE/Python/')
# sys.path.append('/Users/ctang/Microsoft_OneDrive/OneDrive/CODE/CORDEX_AFR_studies/')
import ctang

#=================================================== 
# Create ArgumentParser() object
parser = argparse.ArgumentParser()
# Add argument
parser.add_argument('-f', required=True, help='matfile')
# parser.add_argument('-d', type=list, help='print value in [x,y,z]', default=[0,0,0,0,0])
parser.add_argument('-d', type=list, help='print shape in [x,y,z]')
parser.add_argument('-v', type=list, help='print value in [x,y,z]')
# Print usage
# parser.print_help()
# Parse argument
args = parser.parse_args()


# Print args
# print args
# print args.f
# print type(args.f)
# print args.v
# print type(args.v)

# print args.d
# print type(args.d)


#=================================================== 
a=ctang.Loadmat(args.f)


if (args.v !=None):
    if (len(args.v) == 1):
        print a[args.v].shape,
        print 'is'
        print a[args.v].shape,' in ',a.shape
    
    if (len(args.v) == 2):
        print a[args.v[0],args.v[1]]
        print 'is'
        print a[args.v[0],args.v[1]].shape,' in ',a.shape
    
    if (len(args.v) == 3):
        print a[args.v[0],args.v[1],args.v[2]]
        print 'is'
        print a[args.v[0],args.v[1],args.v[2]].shape,' in ',a.shape
#=================================================== 


if (args.d !=None):
    if (len(args.d) == 1):
        print a[args.d].shape,' in ',a.shape

    if (len(args.d) == 2):
        print a[args.d[0],args.d[1]].shape,' in ',a.shape


if (args.d == None):
    if (args.v == None):
        print a.shape,': ', args.f
