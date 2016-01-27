#!/usr/bin/env python2
from __future__ import division

# get FreeCAD into sys.path
FREECADPATH = '/usr/lib/freecad' # path to your FreeCAD.so or FreeCAD.dll file
import sys
sys.path.append(FREECADPATH)

# inline the ezFreeCAD functions
import urllib
(fn,hd) = urllib.urlretrieve('https://raw.githubusercontent.com/greysAcademicCode/heatedXYZ/master/python/ezFreeCAD/functions.py')
execfile(fn)

# from measurements [mm]
#top and bottom lips
lipOuterD = 365
lipInnerD = lipOuterD-2*(lipOuterD-340)
lipHeight = 15

# flanges
flangeOuterD = lipOuterD
botFlangeThickness = 15
topFlangeThickness = 12
botFlangeStep = 0.75
stepStartD = flangeOuterD - 2*25
stepEndD = flangeOuterD - 2*26.25

# cylinder
totalCylinderHeight = 505
wallInnerD = lipInnerD + 8*2
wallOuterD = lipOuterD - 15*2

# floating plate
plateThickness = 3
windowSquare = 54
plateHeight = 390
plateDiameter = 300

# bottom lip adjust
lipAdjustHeight = 3.6
lipAdjustStartD = lipOuterD - 2*2.5
lipAdjustEndD = lipAdjustStartD - 2*3.6

# three top ports
topPortD = 48
topPortEdgeOffset = 35.9
topPortHeight = 13.75

# viewing port
bottomLipToEdge = 143
vPortBThickness = 42
vPortOuterD = 7.5 * 25.4
vPortCapThickness = 20
vportMinProtrusion = 1

bottomLip=extrude(circle(lipOuterD/2), (0,0,lipHeight))
bottomLip=difference(bottomLip,extrude(circle(lipInnerD/2), (0,0,lipHeight)))

topLip = translate(bottomLip,(0,0,totalCylinderHeight-lipHeight))

cylinderWall = extrude(circle(wallOuterD/2), (0,0,totalCylinderHeight))
cylinderWall = difference(cylinderWall, extrude(circle(wallInnerD/2), (0,0,totalCylinderHeight)))

body = union(bottomLip,cylinderWall)
body = union(body, topLip)
body = difference(body,Part.makeCone(lipAdjustStartD/2,lipAdjustEndD/2,lipAdjustHeight))
#save2DXF(section(body,1),"edgeOfLip.dxf")
save2DXF(section(body),"midSection.dxf")

topFlange = extrude(circle(lipOuterD/2), (0,0,topFlangeThickness))
topFlange = translate(topFlange, (0,0,totalCylinderHeight))

solid2STEP(topFlange, "b40TopFlange.step")
solid2STEP(body, "b40Bell.step")


#solid2STEP(bottomLip, "bl.step")
#solid2STEP(topLip, "tl.step")
#solid2STEP(cylinderWall, "cw.step")


