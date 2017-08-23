#!/usr/bin/env python2

from __future__ import division

import sys
sys.path.append('/usr/lib/freecad/lib') # path to your FreeCAD.so or FreeCAD.dll file
import FreeCAD

import warnings
import ezFreeCAD as ezfc

cutterD = 6.35
cutterR = cutterD/2

recessDim = [28.1,28.1,4] # mm

outerBlockDim = [38,38,6]

deviceRecess2D = ezfc.roundedRectangle(recessDim[0], recessDim[1],r=cutterR,drillCorners=True)
deviceRecess2D = ezfc.translate(deviceRecess2D, -1/2*recessDim[0], -1/2*recessDim[1], 0)
deviceRecess = ezfc.extrude(deviceRecess2D, 0, 0, -recessDim[2])
ezfc.save2DXF(deviceRecess2D, "deviceRecess2D.dxf")

bigWindow2D = ezfc.roundedRectangle(recessDim[0], recessDim[1],r=cutterR)
bigWindow2D = ezfc.translate(bigWindow2D, -1/2*recessDim[0], -1/2*recessDim[1], 0)
bigWindow = ezfc.extrude(bigWindow2D, 0, 0, -outerBlockDim[2])
ezfc.save2DXF(bigWindow2D, "bigWindow2D.dxf")

outerBlock2D = ezfc.roundedRectangle(outerBlockDim[0],outerBlockDim[1],r=2)
outerBlock2D = ezfc.translate(outerBlock2D, -1/2*outerBlockDim[0], -1/2*outerBlockDim[1], 0)
outerBlock = ezfc.extrude(outerBlock2D, 0, 0, -outerBlockDim[2])
ezfc.save2DXF(outerBlock2D, "outerBlock2D.dxf")

part = ezfc.difference(outerBlock, ezfc.union(deviceRecess,bigWindow))

ezfc.solid2STEP(part, "part.step")

capDim = [38,45,6] #mm
capWindowInnerDim = [25,25]
capWindowOuterDim = [recessDim[0]-0.1,recessDim[1]-0.1,recessDim[2]]

capWindowInner2D = ezfc.roundedRectangle(capWindowInnerDim[0], capWindowInnerDim[1],r=cutterR)
capWindowInner2D = ezfc.translate(capWindowInner2D, -1/2*capWindowInnerDim[0], -1/2*capWindowInnerDim[1], 0)
capWindowInner = ezfc.extrude(capWindowInner2D, 0, 0, -capDim[2])
ezfc.save2DXF(capWindowInner2D, "capWindowInner2D.dxf")

capWindowOuter2D = ezfc.roundedRectangle(capWindowOuterDim[0], capWindowOuterDim[1],r=cutterR)
capWindowOuter2D = ezfc.translate(capWindowOuter2D, -1/2*capWindowOuterDim[0], -1/2*capWindowOuterDim[1], 0)
capWindowOuter = ezfc.extrude(capWindowOuter2D, 0, 0, -capDim[2])
ezfc.save2DXF(capWindowOuter2D, "capWindowOuter2D.dxf")

outerCap2D = ezfc.roundedRectangle(capDim[0],capDim[1],r=2)
outerCap2D = ezfc.translate(outerCap2D, -1/2*capDim[0], -1/2*capDim[1], 0)
outerCap = ezfc.extrude(outerCap2D, 0, 0, -capDim[2]+recessDim[2])
ezfc.save2DXF(outerCap2D, "outerCap2D.dxf")

cap = ezfc.difference(ezfc.union(capWindowOuter,outerCap), capWindowInner)
ezfc.solid2STEP(cap, "cap.step")
