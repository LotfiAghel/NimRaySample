static:
    echo "start compile 2"
import lenientops, math, times, strformat, atomics, system/ansi_c
import nimraylib_now
from nimraylib_now/rlgl as rl import nil
#import nimraylib_now/rlight
import GameView
import ../RayNim/Components/[Node,NodeP,Anim]
import ../NimUseFullMacros/macroTool
import ../NimUseFullMacros/ConstructorCreator/ConstructorCreator
import ../NimUseFullMacros/ConstructorCreator/Basic
import rlights
import cc
import ../RayNim/funcs/createSprite

import asyncdispatch
import std/sequtils
import std/sugar
import std/times
import std/strformat
import std/marshal
import std/random
import std/json
import std/deques
import std/locks
import std/json
import std/streams
import ../RayNim/cameraTool








proc loadTexture2(fn:string):Texture2D=
  result=loadTexture(fn)
  genTextureMipmaps(result.addr)
  setTextureFilter(result, 2)
  echo "genTextureMipmaps--------"

static:
    echo "start compile 3"



  



##  Initialization
## --------------------------------------------------------------------------------------

setConfigFlags(Msaa_4x_Hint)

##  Enable Multi Sampling Anti Aliasing 4x (if available)
var tmpZ=1#.5
initWindow(int(screenWidth*tmpZ), int(screenHeight*tmpZ), "raylib [shaders] example - fog")
##  Define the camera to look into our 3d world
var zarib=0.5;
var camera = Camera3D(
    position: (0.0, 0.0, -screenHeight*0.5),
    target: (0.0, 0.0, 0.0),
    up: (0.0, -1.0, 0.0),
    fovy: 90.0,
    projection: Perspective
  )
var camera2D = Camera3D(
    position: (0.0, 0.0, -screenHeight*zarib),
    target: (0.0, 0.0, 0.0),
    up: (0.0, -1.0, 0.0),
    fovy: 90.0,
    projection: PERSPECTIVE
  )
var cameraUI = Camera3D(
    position: (0.0, 0.0, -screenHeight*zarib),
    target: (0.0, 0.0, 0.0),
    up: (0.0, -1.0, 0.0),
    fovy: 90.0,
    projection: PERSPECTIVE
  )
#camera2D=camera;

#[var camera2D = Camera2D(
    offset:(0.0,0.0),
    target: (0.0, 0.0),
    zoom:720
  )]#


var
 
 backGroundNode:GNode

 
 











var font:Font


var swirlCenter: array[2, cfloat] 
var first:bool=true
var
  fxWav :Sound
  #fxOgg :Sound
import std/tables




#[creator["EndGame"] = (proc(inp:string)=
  let c = to[EndGame](inp)
  gameView2.endGame(c)
)]#






proc onClick0()=
  echo "onClick0"
proc onClick2()=
  echo "onClick0"


var inited=false
proc initAssets()=
  echo "initAssets"
  
  font = loadFontEx("resources/game/OpenSans-Bold.ttf", 64, nil, 0)
  fxWav = loadSound("resources/sound.wav")         #  Load WAV audio file
  #fxOgg = loadSound("resources/guitar_noodling.ogg")      #  Load OGG audio file

  
  setSoundVolume fxWav, 0.8
  
  defaultCamera=camera

  ##  Load models and texture
  var z=genMeshTorus(0.4, 1.0, 16, 32)
  var z2:Mesh=z;

  echo z.texcoords.addr == z2.texcoords.addr

  #z2.vertexCount=z.vertexCount
  
  emptyWhite = loadTexture2("resources/w.png")
  circle = loadTexture2("resources/raysan.png")

  

  
  
  #backGroundNode = spriteNodeCreate(circle).setPostion((screenWidth/2, screenHeight/2, 0.0))
  backGroundNode = spriteNodeCreate(circle).setPostion((0.0,0.0,0.0))
  backGroundNode.addOnUpdate(SetTransformTo.Create(
    scaleProvider=LinearProvider[Vector3](
      time: SinEfect(valueSource:LinearProvider[float](
        time:globalTime,
        start: 0.0,
        endPosition: 20.0
      )),
      start: (0.0,0.0,0.0),
      endPosition: (10.0,10.0,10.0)
    ),
    rotateProvider= ConstProvider[Vector3](value:(0.0,0.0,0.0))
  ))
  #[
    scale(sin(globalTime.value*20)*(10,10,10))
  ]#


 



 



  
  ##  Using just 1 point lights
  setCameraMode(camera2D, FREE)
  setCameraMode(camera, FREE)
  camera.position = (0.0,0.0,-1.0)
  #discard camera.lookAt((0.0,0.0,-1.0),(0.0,0.0,0.0),(0.0,1.0,0.0))
  ##  Set an orbital camera mode
  setTargetFPS(60)
  ##  Set our game to run at 60 frames-per-second
  ## --------------------------------------------------------------------------------------
  ##  Main game loop
  
 
  inited=true

  

 
 
  swirlCenter = [(screenWidth div 2).cfloat, (screenHeight div 2).cfloat]

  
  echo "go to init floor"
  
  
  
  echo "init assets"

 




var asstes_inited=false

import macros
dumpTree:
  now().utc
import system
import os


      
const myResource = "todo"
var ddata : DragDataPtr =nil

var zz=0.0#camera2D.target.z
var
    g0= Vector3(x: 1000000.0,y: 1000000.0,z:zz)
    g1= Vector3(x: 1000000.0,y: -1000000.0,z:zz)
    g2= Vector3(x: -1000000.0,y: -1000000.0,z:zz)
    g3= Vector3(x: -1000000.0,y: 1000000.0,z:zz)
proc getGroundPostion(pos:Vector2):Vector3=
  var ray = getMouseRay(pos, camera2D);
  var dz = ray.position.z/ray.direction.z 
  #var gp=ray.position-ray.direction*dz

  var groundHitInfo = getRayCollisionQuad(ray, g0, g1, g2, g3);
  result=groundHitInfo.point
var gorundPostion:Vector3
var matrix:Matrix
proc getScreenPostion(pos:Vector3):Vector2=
  discard


var allDrag=DragPoint(
        onStart: proc(d:DragDataPtr)=
          echo "allDrag.onStart"
          #cameraPoint=camera2D.target
          gorundPostion = d.globalCurPosition.addZ(0.0) #getGroundPostion(d.globalCurPosition)
          #matrix=camera2D.getCameraMatrix()
        ,
        onMove: proc(d:DragDataPtr)=
          #var gorundPostion = getGroundPostion(d.globalStartPosition)
          var gorundPostion2 = d.globalCurPosition.addZ(0.0)
          #var tmp=getScreenPostion(gorundPostion)

          #var cameraPoint = d.globalCurPosition

          camera2D.target -= gorundPostion2-gorundPostion
          camera2D.position -= gorundPostion2-gorundPostion

          
          
          #t.rect.y=d.globalCurPosition.y
      )

proc UpdateGameWindow() {.cdecl.} =
  echo "UpdateGameWindow"
  try:
    when not defined(emscripten):
      if inited:
        try:
          asyncdispatch.poll(0)
        except:
          discard

    if download_parm>0:
      echo fmt"downloading assets {download_parm}"
      return;
    
    if not asstes_inited:
      echo "Finished3 all downloads"  
      initAssets()
    if isKeyPressed(ENTER): playSoundMulti fxWav  
    asstes_inited=true
    ##  Update
    ## ----------------------------------------------------------------------------------
    #updateCamera(addr(camera))
    #updateCamera(addr(camera2D))

    #echo camera2D.position
    #camera2D.position.z =camera2D.position.z+1;
    #camera.position.z = camera.position.z+1;
    #updateCamera(addr(camera))
    #updateCamera(addr(camera2D))
    #camera.setCameraPosition(camera.position)
    #setCameraPosition(camera.position)
    #echo camera2D.position
    
    
    var mousePosition: Vector2 = getMousePosition()
    var mouseWheel=getMouseWheelMove()
    var moseGround=getGroundPostion(mousePosition)
    #moseGround=gp
    if camera2D.projection == Perspective:
      if(mouseWheel<0):
        

        #pZ = pZ*0.9
        
        
        camera2D.position = camera2D.position*0.9+moseGround*0.1
        camera2D.target = camera2D.target*0.9+moseGround*0.1
        #camera2D.position.z = camera2D.position.z*1.1
        

      if(mouseWheel>0):
        #pZ = pZ*1.1
        
        camera2D.position = camera2D.position*1.1+moseGround*(-0.1)
        camera2D.target = camera2D.target*1.1+moseGround*(-0.1)
        #camera2D.position.z = camera2D.position.z*0.9
        #camera.position = (0.0,0.0,-1.0)
        
    else:
      if(mouseWheel<0):
        camera2D.fovy = camera2D.fovy*0.9
        camera2D.target = camera2D.target*0.9+moseGround*(0.1)
      if(mouseWheel>0):
        camera2D.fovy = camera2D.fovy*1.1
        camera2D.target = camera2D.target*1.1+moseGround*(-0.1)

    swirlCenter[0] = mousePosition.x
    swirlCenter[1] = screenHeight.float - mousePosition.y
    ##  Send new value to the shader to be used on drawing


    globalTime.value+=0.017
    
    
    backGroundNode.update()
    
    
    
    beginDrawing:
      clearBackground(Gray)
      
      
      var zdis= -camera2D.position.z
      
      if isMouseButtonDown(MouseButton.Left) and ddata.isNil:
        var minDis:cfloat=10000;
        var minDA:DragPoint=nil
        for  rect in clickListener:
          echo moseGround
          var dis= distance(moseGround,rect.pos)
          if dis < zdis*0.05 and dis<minDis:
              minDis = dis
              minDA=rect
        if not minDA.isNil:
          minDA.btn.transform=scale(1.05,1.05,1.0)
          ddata =  DragDataPtr(globalStartPosition:moseGround.rmZ(),globalCurPosition:moseGround.rmZ(),target:minDA)
          ddata.target.onStart(ddata)
        else:
          #discard
          ddata =  DragDataPtr(globalStartPosition:moseGround.rmZ(),globalCurPosition:moseGround.rmZ(),target:allDrag)
          ddata.target.onStart(ddata)

      
      if (isMouseButtonReleased(MouseButton.Left)):
        if not ddata.isNil:
          if not ddata.target.onEnd.isNil:
            ddata.target.onEnd(ddata)
          ddata = nil

      
      if not ddata.isNil and ddata.target != allDrag :
        ddata.globalCurPosition = moseGround.rmZ()
        ddata.target.onMove(ddata)

      if not ddata.isNil and ddata.target == allDrag :
        ddata.globalCurPosition = moseGround.rmZ()
        ddata.target.onMove(ddata)

      
      
      
    

      beginMode3D(camera):
        ##  Draw the three models
        #drawModel(modelA, vector3Zero(), 1.0, White)
        #drawModel(modelB, (-2.6, 0.0, 0.0), 1.0, White)
        #drawModel(modelC, (2.6, 0.0, 0.0), 1.0, White)
        when false :
          var i = -20
          while i < 20:
            drawModel(modelA, (i.float, 0.0, 2.0), 1.0, White)
            inc(i, 2)
          
          
          
                
        
        #maskedView.visit((0.0,0.0,0.0),scale(1.0,1.0,1.0),camera)
      

        first=false

      
      when true:  
        myBeginMode3D(camera2D,1.0/aspect,-camera2D.position.z*0.5,-camera2D.position.z*1.5): ##  Begin 3d mode drawing
          clearBackground((0,0,0,0))
          #allOfGame.visit((0.0,0.0,0.0),scale(1.0,1.0,1.0),camera2D)
          #cardRects.visit(globalScreenPos,globalScaleMatrix,camera2D)  
          backGroundNode.visit(globalScreenPos,globalScaleMatrix,camera2D)  
          #drawTextEx(font, fmt"[{rand(10)} Parrots font drawing]", Vector2(x:  20,y:  20 + 280), (float)font.baseSize, 0.0, White)
 
      


      
      
      
      #drawTextEx(font, "[3 Parrots font drawing]", Vector2(x:  20, y:  20 + 280), (float)font.baseSize, 0.0, White)
  except : 
    let
      e = getCurrentException()
      msg = getCurrentExceptionMsg()
    echo "Got exception ", repr(e), " with message ", msg
    echo "I Got Error"
  echo "</UpdateGameWindow>"


proc main0*() =


  when not defined(emscripten) :
    while not windowShouldClose():
      UpdateGameWindow()
    echo "!emscripten"
    ECHO "!emscripten"
  else:
    echo "go to run emscriptenSetMainLoop"
    emscriptenSetMainLoop(UpdateGameWindow, 0, 1)
    echo "emscripten"
    ECHO "emscripten"

  ##  De-Initialization
  ## --------------------------------------------------------------------------------------
  
  ##  Unload the model A
  #unloadModel(modelB)
  ##  Unload the model B
  
  
  closeWindow()
  ##  Close window and OpenGL context
  ## --------------------------------------------------------------------------------------
  #closeWindow()

when isMainModule: main0()




