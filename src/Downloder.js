var createDir=function(path){
    try{
      FS.mkdir("resources");
    }catch{

    }
    
  }
  var z=async function() {
    alert(1)
    
    console.log(FS)
    createDir("resources");
    console.log(FS)
    createDir("resources/shaders/")
    console.log(FS)
    createDir("resources/shaders/glsl100/")
    console.log(FS)

    
    

    var png1=["/resources/texel_checker.png","resources/shaders/glsl100/mask2.fs","resources/texel_checker2.png","resources/plasma.png","resources/mask.png"]
    for (let i = 0; i < png1.length; i++){
      var response=await fetch(png1[i], { credentials: 'same-origin' });
      var a=await response['arrayBuffer']()
      FS.writeFile(png1[i], new Uint8Array(a))
    }
        
      
    
    
  }
  setTimeout(z, 1000);