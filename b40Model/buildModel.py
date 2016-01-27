#!/usr/bin/env python2
FREECADPATH = '/usr/lib/freecad' # path to your FreeCAD.so or FreeCAD.dll file
import sys
sys.path.append(FREECADPATH)
import FreeCAD
import Part
import importDXF
mydoc = FreeCAD.newDocument("mydoc")

def rectangle(xDim,yDim):
    return Part.makePlane(xDim,yDim)

def circle(radius):
    circEdge = Part.makeCircle(radius)
    circWire = Part.Wire(circEdge)
    circFace = Part.Face(circWire)
    return circFace

# only tested/working with solid+solid and face+face
def union(thingA,thingB,tol=1e-5):
    if (thingA.ShapeType == 'Face') and (thingB.ShapeType == 'Face'):
        u = thingA.multiFuse([thingB],tol).removeSplitter().Faces[0]
    elif (thingA.ShapeType == 'Solid') and (thingB.ShapeType == 'Solid'):
        u = thingA.multiFuse([thingB],tol).removeSplitter().Solids[0]
    else:
        u = []
    return u

# TODO: this cut is leaving breaks in circles, try to upgrade it to fuzzy logic with tolerance
# also remove splitter does nothing here
def difference(thingA,thingB):
    if (thingA.ShapeType == 'Face') and (thingB.ShapeType == 'Face'):
        d = thingA.cut(thingB).removeSplitter().Faces[0]
    elif (thingA.ShapeType == 'Solid') and (thingB.ShapeType == 'Solid'):
        d = thingA.cut(thingB).removeSplitter().Solids[0]
    else:
        d = []
    return d

def save2DXF (thing,outputFilename):
    tmpPart = mydoc.addObject("Part::Feature")
    tmpPart.Shape = thing
    importDXF.export([tmpPart], outputFilename)
    mydoc.removeObject(tmpPart.Name)
    return

def solid2STEP (solid,outputFilename):
    solid.exportStep(outputFilename)
    return

def extrude (face,direction):
    return face.extrude(FreeCAD.Vector(direction))

def translate (obj,direction):
    tobj = obj.copy()
    tobj.translate(FreeCAD.Vector(direction))
    return tobj

def section (solid,height="halfWay"):
    bb = solid.BoundBox
    if height == "halfWay":
        zPos = bb.ZLength/2
    else:
        zPos = height
    slicePlane = rectangle(bb.XLength, bb.YLength)
    slicePlane.translate(FreeCAD.Vector(bb.XMin,bb.YMin,zPos))
    sectionShape = solid.section(slicePlane)
    return sectionShape

# from measurements [mm]
#top and bottom lips
lipOuterD = 365.0
lipInnerD = lipOuterD-2*(lipOuterD-340.0)
lipHeight = 15.0

# flanges
flangeOuterD = lipOuterD
botFlangeThickness = 15.0
topFlangeThickness = 12.0
botFlangeStep = 0.75
stepStartD = flangeOuterD - 2*25.0
stepEndD = flangeOuterD - 2*26.25

# cylinder
totalCylinderHeight = 505.0
wallInnerD = lipInnerD + 8.0*2
wallOuterD = lipOuterD - 15.0*2

# floating plate
plateThickness = 3.0
windowSquare = 54.0
plateHeight = 390.0
plateDiameter = 300.0

# bottom lip adjust
lipAdjustHeight = 3.6
lipAdjustStartD = lipOuterD - 2*2.5
lipAdjustEndD = lipAdjustStartD - 2*3.6

# three top ports
topPortD = 48.0
topPortEdgeOffset = 35.9
topPortHeight = 13.75

bottomLip=extrude(circle(lipOuterD/2), (0,0,lipHeight))
bottomLip=difference(bottomLip,extrude(circle(lipInnerD/2), (0,0,lipHeight)))

topLip = translate(bottomLip,(0,0,totalCylinderHeight-lipHeight))

cylinderWall = extrude(circle(wallOuterD/2), (0,0,totalCylinderHeight))
cylinderWall = difference(cylinderWall, extrude(circle(wallInnerD/2), (0,0,totalCylinderHeight)))

body = union(bottomLip,cylinderWall)
body = union(body, topLip)
body = difference(body,Part.makeCone(lipAdjustStartD/2,lipAdjustEndD/2,lipAdjustHeight))
#save2DXF(section(body,1),"edgeOfLip.dxf")
#save2DXF(section(body),"midSection.dxf")

topFlange = extrude(circle(lipOuterD/2), (0,0,topFlangeThickness))
topFlange = translate(topFlange, (0,0,totalCylinderHeight))

solid2STEP(topFlange, "b40TopFlange.step")
solid2STEP(body, "b40Bell.step")


#solid2STEP(bottomLip, "bl.step")
#solid2STEP(topLip, "tl.step")
#solid2STEP(cylinderWall, "cw.step")


