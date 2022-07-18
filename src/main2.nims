if true:
  echo "define emscripten"
  --define:emscripten # Specify target
  #--bind -s FETCH=1
  --os:linux # Emscripten pretends to be linux.
  --cpu:wasm32 # Emscripten is 32bits.
  --cc:clang # Emscripten is very close to clang, so we will replace it.
  when defined(windows):
    --clang.exe:emcc.bat  # Replace C
    --clang.linkerexe:emcc.bat # Replace C linker
    --clang.cpp.exe:emcc.bat # Replace C++
    --clang.cpp.linkerexe:emcc.bat # Replace C++ linker.
  else:
    --clang.exe:emcc   # Replace C
    --clang.linkerexe:emcc # Replace C linker
    --clang.cpp.exe:emcc # Replace C++
    --clang.cpp.linkerexe:emcc # Replace C++ linker.
  --passC: "-s FETCH -s ALLOW_MEMORY_GROWTH=1"
  --passL: "-s FETCH -s ALLOW_MEMORY_GROWTH=1"
  
  #--gc:orc # GC:orc is friendlier with crazy platforms.
  --exceptions:goto # Goto exceptions are friendlier with crazy platforms.
  --define:noSignalHandler # Emscripten doesn't support signal handlers.
  --define:noInitialRun # khodam add kardam doesent work
  --nimcache:"cache/wasm"
else:
  echo "salam"