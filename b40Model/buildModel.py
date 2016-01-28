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

# cylinder
totalCylinderHeight = 505
wallInnerD = lipInnerD + 8*2
wallOuterD = lipOuterD - 15*2
wallThickness = (wallOuterD - wallInnerD)/2

# floating plate
plateThickness = 3
windowSquare = 54
plateHeight = 390
plateDiameter = 300

# bottom lip adjust
lipAdjustHeight = 3.6
lipAdjustStartD = lipOuterD - 2*2.5
lipAdjustEndD = lipAdjustStartD - 2*lipAdjustHeight
botFlangeOuterD = lipAdjustEndD

# flanges
botFlangeThickness = 15
topFlangeThickness = 12
botFlangeStep = 0.75
stepStartD = botFlangeOuterD - 2*25
stepEndD = botFlangeOuterD - 2*26.25

# three top ports
topPortD = 48
topPortEdgeOffset = 35.9
topPortHeight = 13.75

# viewing port
bottomLipToEdge = 143
vPortBThickness = 42
vPortOuterD = 7.5 * 25.4
vPortCapThickness = 20
vportMinProtrusion = 10

evapDim = 56

bottomLip=extrude(circle(lipOuterD/2),0,0,lipHeight)
bottomLip=difference(bottomLip,extrude(circle(lipInnerD/2),0,0,lipHeight))

topLip = translate(bottomLip,0,0,totalCylinderHeight-lipHeight)

cylinderWall = extrude(circle(wallOuterD/2),0,0,totalCylinderHeight)
vPort = cylinder(vPortOuterD/2,wallOuterD/2+vportMinProtrusion)
vPort = rotate(vPort,-90,0,0)
vPort = translate(vPort,0,0,bottomLipToEdge+vPortOuterD/2+lipHeight)
cylinderWall = union(cylinderWall,vPort)
cylinderWall = difference(cylinderWall, extrude(circle(wallInnerD/2),0,0,totalCylinderHeight))
cylinderWall = difference(cylinderWall,translate(rotate(cylinder(vPortOuterD/2-wallThickness,lipOuterD/2+vportMinProtrusion),-90,0,0),0,0,bottomLipToEdge+vPortOuterD/2+lipHeight))

vPortCap = difference(cylinder(vPortOuterD/2,vPortCapThickness),cylinder(vPortOuterD/2-vPortBThickness,vPortCapThickness))
vPortCap = translate(rotate(vPortCap,-90,0,0),0,wallOuterD/2+vportMinProtrusion,bottomLipToEdge+vPortOuterD/2+lipHeight)

body = union(bottomLip,cylinderWall)
body = union(body, topLip)
body = difference(body,Part.makeCone(lipAdjustStartD/2,lipAdjustEndD/2,lipAdjustHeight))
#save2DXF(section(body,1),"edgeOfLip.dxf")
#save2DXF(section(body),"midSection.dxf")

topFlange = extrude(circle(lipOuterD/2),0,0,topFlangeThickness)
topFlange = translate(topFlange,0,0,totalCylinderHeight)

floatingPlate = circle(plateDiameter/2)
floatingPlate = difference(floatingPlate,translate(rectangle(windowSquare,windowSquare),-windowSquare/2,-windowSquare/2,0))
floatingPlate = extrude(floatingPlate,0,0,plateThickness)
floatingPlate = translate(floatingPlate,0,0,plateHeight+lipAdjustHeight+botFlangeStep)

bottomFlange = union(cylinder(botFlangeOuterD/2,botFlangeThickness),translate(cone(stepStartD/2,stepEndD/2,botFlangeStep),0,0,botFlangeThickness))
bottomFlange = translate(bottomFlange,0,0,-botFlangeThickness+lipAdjustHeight)

evapPlane = translate(rectangle(evapDim,evapDim),-evapDim/2,-evapDim/2,plateHeight+lipAdjustHeight+botFlangeStep+plateThickness)

motorXYOffset = 38.0330
motor = STEP2Solid("665921.STP")
motor = translate(motor,-motorXYOffset,motorXYOffset,plateHeight+lipAdjustHeight+botFlangeStep)

solid2STEP(topFlange, "output/topFlange.step")
solid2STEP(body, "output/body.step")
solid2STEP(vPortCap, "output/vPortCap.step")
solid2STEP(floatingPlate, "output/floatingPlate.step")
solid2STEP(bottomFlange, "output/bottomFlange.step")
solid2STEP(motor, "output/motor.step")
solid2STEP(evapPlane, "output/evapPlane.step")


