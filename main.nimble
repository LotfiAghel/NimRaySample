# Package

version       = "0.1.0"
author        = "akira noguchi"
description   = "A new awesome nimble package"
license       = "MIT"
srcDir        = ""
bin           = @["src/main"]
backend             = "c"

requires "nim >= 0.20.2"
requires  "nimraylib_now"
requires "constructor"
