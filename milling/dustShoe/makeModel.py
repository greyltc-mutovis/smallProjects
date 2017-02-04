#!/usr/bin/env python2
from __future__ import division

import sys
sys.path.append('/usr/lib/freecad') # path to your FreeCAD.so or FreeCAD.dll file
import FreeCAD

import ezFreeCAD as ezfc

tehLines = ezfc.loadDXF("2d.dxf") 

thickness = 19
topHalf = ezfc.difference(ezfc.extrude(tehLines["topHalf"],0,0,thickness),ezfc.extrude(tehLines["mountingHoles"],0,0,thickness))

ezfc.solid2STEP(topHalf, "topHalf.step")