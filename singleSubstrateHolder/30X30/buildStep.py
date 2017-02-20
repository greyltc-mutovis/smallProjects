#!/usr/bin/env python2

from __future__ import division

import sys
sys.path.append('/usr/lib/freecad') # path to your FreeCAD.so or FreeCAD.dll file
import FreeCAD

import warnings
import ezFreeCAD as ezfc

cutterD = 6.35
cutterR = cutterD/2

recessDim = [30.1,2.2] # mm

outerBlockDim = [38,38,6]

deviceRecess2D = ezfc.roundedRectangle(recessDim[0], recessDim[0],r=cutterR,drillCorners=True)
deviceRecess2D = ezfc.translate(deviceRecess2D, -1/2*recessDim[0], -1/2*recessDim[0], 0)
deviceRecess = ezfc.extrude(deviceRecess2D, 0, 0, -recessDim[1])
ezfc.save2DXF(deviceRecess2D, "deviceRecess2D.dxf")

bigWindow2D = ezfc.roundedRectangle(recessDim[0], recessDim[0],r=cutterR)
bigWindow2D = ezfc.translate(bigWindow2D, -1/2*recessDim[0], -1/2*recessDim[0], 0)
bigWindow = ezfc.extrude(bigWindow2D, 0, 0, -outerBlockDim[2])
ezfc.save2DXF(bigWindow2D, "bigWindow2D.dxf")


outerBlock2D = ezfc.roundedRectangle(outerBlockDim[0],outerBlockDim[1],r=2)
outerBlock2D = ezfc.translate(outerBlock2D, -1/2*outerBlockDim[0], -1/2*outerBlockDim[1], 0)
outerBlock = ezfc.extrude(outerBlock2D, 0, 0, -outerBlockDim[2])
ezfc.save2DXF(outerBlock2D, "outerBlock2D.dxf")

part = ezfc.difference(outerBlock, ezfc.union(deviceRecess,bigWindow))

ezfc.solid2STEP(part, "part.step")