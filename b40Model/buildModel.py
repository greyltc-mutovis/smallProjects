#!/usr/bin/env python2
from __future__ import division

# get FreeCAD into sys.path
FREECADPATH = '/usr/lib/freecad' # path to your FreeCAD.so or FreeCAD.dll file
import sys
sys.path.append(FREECADPATH)

# inline the ezFreeCAD functions
internet=False
if internet:
    import urllib
    (fn,hd) = urllib.urlretrieve('https://raw.githubusercontent.com/greysAcademicCode/heatedXYZ/master/python/ezFreeCAD/functions.py')
    execfile(fn)
else:
    pathToezFreecad="../../heatedXYZ/python/ezFreeCAD"
    execfile(pathToezFreecad+"/functions.py")
    

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

# this stuff helps visualize the evaporation
evapPlane = translate(rectangle(evapDim,evapDim),-evapDim/2,-evapDim/2,plateHeight+lipAdjustHeight+botFlangeStep+plateThickness)
pointSourceZ = 80 #random guess
sourcePoint = Part.Vertex(0,0,pointSourceZ)
loftBits = evapPlane.Wires
loftBits.append(sourcePoint)
ballisticTrajectory = Part.makeLoft(loftBits,True).Solids[0]

# stepper motor
motorXOffset = 54.2024 
motorYOffset = 12.3865
motor = STEP2Solid("665921.STP")
motorA = translate(motor,motorXOffset,motorYOffset,plateHeight+lipAdjustHeight+botFlangeStep)
motor = mirror(motorA,motorXOffset,motorYOffset,plateHeight+lipAdjustHeight+botFlangeStep+6.5,0,0,1)
motorMountD = 3.3 # TODO: double check this
motorMountSpacing = 21.7 # TODO: double check this

#mask carousel
carouselD = 188.8007
carouselT = 3
carouselZOffset = 5
carousel = circle(carouselD/2)
carousel = extrude(carousel,0,0,carouselT)

# mask windows
# window offset from center of wheel
maskWinDx = 26.2024
maskWinDy = -15.6135
maskCutout = rectangle(evapDim,evapDim)
maskCutout = extrude(maskCutout,0,0,carouselT)
# pocket for mask to sit in
maskPocketDepth = 0.6
maskPocketOffset = 2
maskPocketDim = evapDim + maskPocketOffset*2;
maskPocket = rectangle(maskPocketDim,maskPocketDim)
maskPocket = translate(maskPocket,-maskPocketOffset,-maskPocketOffset,carouselT)
maskPocket = extrude(maskPocket,0,0,-maskPocketDepth)
maskCutout = union(maskCutout,maskPocket)

# chamfer the mask edges
chamferBottomFace = rectangle(maskPocketDim,maskPocketDim)
chamferBottomFace = translate(chamferBottomFace,-maskPocketOffset,-maskPocketOffset,0)
chamferTopFace = rectangle(evapDim,evapDim)
chamferTopFace = translate(chamferTopFace,0,0,2)
loftBits = chamferBottomFace.Wires
loftBits.append(chamferTopFace.Wires[0])
chamferSolid = Part.makeLoft(loftBits,True).Solids[0]
maskCutout = union(maskCutout,chamferSolid)

maskCutout = translate(maskCutout,maskWinDx,maskWinDy,0)# move the window into position
maskCutouts = circArray(maskCutout,4,0,0,0,0,0,1) # duplicate it

# subtract the windows from the wheel
carousel = difference(carousel,maskCutouts[0])
carousel = difference(carousel,maskCutouts[1])
carousel = difference(carousel,maskCutouts[2])
carousel = difference(carousel,maskCutouts[3])

# cutout motor shaft hole
motorShaftD=4
shaftCutoutD=motorShaftD+0.1
shaftCutout=cylinder(shaftCutoutD/2,carouselT)
carousel = difference(carousel,shaftCutout)

# universal hub mounting holes
# designed for this https://www.pololu.com/product/1997
m3ClearanceD=3.2
fourHolesOffset=6.35
hubMount =cylinder(m3ClearanceD/2,carouselT)
hubMount = translate(hubMount,fourHolesOffset,0,0)
hubMounts = circArray(hubMount,4,0,0,0,0,0,1)
# subtract the mounting holes from the wheel
carousel = difference(carousel,hubMounts[0])
carousel = difference(carousel,hubMounts[1])
carousel = difference(carousel,hubMounts[2])
carousel = difference(carousel,hubMounts[3])

carouselSlice = section(carousel)
save2DXF(carousel, "output/carouselSlice.dxf")

# move the mask wheel into position
carousel = translate(carousel,motorXOffset,motorYOffset,plateHeight+lipAdjustHeight+botFlangeStep+carouselZOffset)

bracketWidth=33 # the same as the motor diameter
bracketThickness=plateThickness
p0 = FreeCAD.Vector(0,0,0)
p1 = FreeCAD.Vector(0,0,-10)
p2 = FreeCAD.Vector(0,7,-10)
p3 = FreeCAD.Vector(0,7,-210)
p4 = FreeCAD.Vector(0,0,-210)
p5 = FreeCAD.Vector(0,0,-220)
e0 = Part.makeLine(p0,p1)
e1 = Part.makeLine(p1,p2)
e2 = Part.makeLine(p2,p3)
e3 = Part.makeLine(p3,p4)
e4 = Part.makeLine(p4,p5)
eList = [p0,p1,p2,p3,p4,p5]
wire=Part.Wire([e0,e1,e2,e3,e4])
toSweep = rectangle(bracketWidth,bracketThickness)
bracket = wire.makePipeShell(toSweep.Wires,True,False,1)
bracket = translate(bracket,-bracketWidth/2,0,220/2)
bracket = rotate(bracket,0,13,0)
bracket = rotate(bracket,90,0,0)
bracket = translate(bracket,motorXOffset,motorYOffset,plateHeight+lipAdjustHeight+botFlangeStep+plateThickness)

solid2STEP(bracket, "output/bracket.step")
solid2STEP(topFlange, "output/topFlange.step")
solid2STEP(body, "output/body.step")
solid2STEP(vPortCap, "output/vPortCap.step")
solid2STEP(floatingPlate, "output/floatingPlate.step")
solid2STEP(bottomFlange, "output/bottomFlange.step")
solid2STEP(motor, "output/motor.step")
solid2STEP(evapPlane, "output/evapPlane.step")
solid2STEP(carousel, "output/carousel.step")
solid2STEP(ballisticTrajectory, "output/ballisticTrajectory.step")


