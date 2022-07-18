import std/strformat
import std/strutils
import std/uri










from os import parentDir, `/`


type ReciveCallBak* = proc(a:string) 
  


var reciveCallBack*:ReciveCallBak=nil

var download_parm* =0;

when defined(emscripten) :
  const ccHeader = currentSourcePath().parentDir()/"cc.h"
  {.passC: "-DRLIGHTS_IMPLEMENTATION".}
  static:
    echo "emscriptenemscriptenemscriptenemscriptenemscriptenemscriptenemscriptenemscriptenemscripten"
  proc emscripten_run_script(scriptstr: cstring) {.header: "<emscripten.h>",
    importc: "emscripten_run_script".}

  proc msleep*(s:cint){.importc: "$1" .}
  
  proc wasmWssConnect*(url:cstring)=
    
    var js=fmt"wsConnect('{url}');"
    echo js
    emscripten_run_script(
        js
    )

    #[js=fmt"downloadAndSave('asdfasdf',{1});"
    echo js
    download_parm = download_parm + 1;
    emscripten_run_script(
        js
    )]#
    
  proc requestFullscreen*()=
    
      var js=fmt"requestFullscreen();".replace("\\","\\\\")
      echo js
      emscripten_run_script(
          js
      )

  proc wasmWssSend*(data:cstring)=
    
    var js=fmt"wsSend('{data}');".replace("\\","\\\\")
    echo js
    emscripten_run_script(
        js
    )

    #[js=fmt"downloadAndSave('asdfasdf',{1});"
    echo js
    download_parm = download_parm + 1;
    emscripten_run_script(
        js
    )]#
    
    

  proc wasmDownload(s:cstring){.importc: "$1" .}
  proc wasmDownload2*(s:cstring)=
    download_parm = download_parm + 1
    wasmDownload(s)


  proc endDownload*(s:cint):cint {.importc: "$1",header: ccHeader.}

  proc download*(path:string,pid:int)=
    

    echo "downloadLock.acquire ed"
    var js=fmt"downloadAndSave('{path}',{pid});"
    echo js
    download_parm = download_parm + 1;
    emscripten_run_script(
        js
    )
    
    echo "emscripten_run_script end"
    echo "downloadLock.acquire ed 2"

  proc getFileLockFromUrl*(url0:cstring,fn0:cstring){.cdecl,exportc: "$1" , dynlib.}=
    var url=cast[ptr UncheckedArray[char]](url0)
    var fn=cast[ptr UncheckedArray[char]](fn0)
    var temp:string=""
    
    var i=0
    while url[i] != chr(0):
      temp.add(url[i])
      i = i+1

    let host = parseUri(temp)
    echo host.path
    for idx,val in host.path:
      fn[idx] = val
    fn[temp.len]=chr(0)
    echo fn
  
  proc wssRecive2*(proc_id:cstring):int{.cdecl,exportc: "$1" , dynlib.}=
    echo "call wssRecive2 from js side"
    echo proc_id.len

    if reciveCallBack!=nil:
      reciveCallBack($(proc_id))
    
    
  proc endDownload2*(proc_id:cint):int{.cdecl,exportc: "$1" , dynlib.}=
    echo "call endDownload2 from js side"
    
    var js=fmt"alert('nim call from js with arg={proc_id} {download_parm}');"
    echo js
    download_parm = download_parm - 1
    #[emscripten_run_script(
        js
    )]#
    
  
  

else:
  import asyncdispatch, ws

  var ws2:WebSocket=nil
  
  proc handleRecive(ws2:WebSocket)=
    
    var future = ws2.receiveStrPacket()
    future.addCallback(
      proc (){.closure, gcsafe.} =
        var z=future.read
        reciveCallBack(z)
        handleRecive(ws2)
    )
  proc wasmWssConnect*(s:string) =
    var ws=newWebSocket(s)
    ws.addCallback(
      proc(){.closure, gcsafe.}=
        
        echo "hi---------------------------------hi"
        var ws3=ws.read
        ws2=ws3
        handleRecive(ws3)
        #echo future.read
    )
    
    

      
    
    
  proc wasmWssSend*(s:string)=
    discard ws2.send(s)
    echo "wasmWssSend ",s

  proc wasmDownload(s:cstring)=
    echo s
  proc wasmDownload2*(s:cstring)=
    download_parm = download_parm + 1
    wasmDownload(s)
    download_parm = download_parm - 1

  proc download*(path:string,id:cint)=
    #download_parm = download_parm + 1
    echo "dont neead download"
  proc endDownload*(s:cint):cint =
    download_parm = download_parm - 1
    echo "end"
    return 0
  proc endDownload2*(proc_id:cint):int=
    download_parm = download_parm - 1
    echo "end download2"
    return 0

proc just_for_Optimisation_not_clear_Blow_function*()=
  download_parm =download_parm + 2
  discard endDownload2(0)
  discard endDownload(1);

echo "nim got wasmWssConnect"  
