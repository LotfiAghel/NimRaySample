import lenientops, math, times, strformat, atomics, system/ansi_c
import nimraylib_now
from nimraylib_now/rlgl as rl import nil
import std/sequtils
import std/sugar
import std/times
import std/strformat
from os import existsFile
import asyncdispatch
import cc
import std/tables
import ../RayNim/funcs/createSprite
import ../NimUseFullMacros/ConstructorCreator/ConstructorCreator
var designResolution* = Vector2(x:1980.0,y:1080)
var screenWidth* = int(designResolution.x*0.9)
var screenHeight* = int(designResolution.y*0.9)


designResolution = Vector2(x:screenWidth.float,y:screenHeight.float)
var aspect* = (designResolution.y/designResolution.x).float
var globalScale* = screenHeight*1.0 / designResolution.y;
var globalScaleMatrix* =scale(globalScale,globalScale,globalScale)
var globalScreenPos* :Vector3 = Vector3(x: -screenWidth/2,y: -screenHeight/2,z:0.0) ;

globalScreenPos = Vector3(x: 0,y: 0,z:0.0) ;
#designResolution = Vector2(x:1280.0,y:720)





      
echo "go to download"
just_for_Optimisation_not_clear_Blow_function()
download_parm=download_parm+1

var assets:seq[string]= @["resources/texel_checker.png",
            "resources/w.png",
            "resources/texel_checker2.png",
            "resources/plasma.png",
            "resources/raysan.png",


            "resources/game/OpenSans-Bold.ttf",
            "resources/mask.png",
            "resources/floorplan.json",

            
            ]
    
for idx,val in assets:
  wasmDownload2(fmt"{val}")
download_parm=download_parm-1
echo "come from download"



static :
  echo "CompileTime= " , CompileTime
echo "CompileTime= " , CompileTime

import ../RayNim/Components/[Node,Anim,NodeP]



var globalTime* = new TimeProvider
globalTime.value=0;







var circle*:Texture2D

var emptyWhite*:Texture2D



var clickListener* :seq[DragPoint]


    

