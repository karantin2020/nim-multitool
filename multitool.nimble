# Package

version       = "0.1.1"
author        = "karantin2020"
description   = "Collection of common procs to use with data in nim"
license       = "MIT"

srcDir = "src"

# Dependencies

requires "nim >= 0.12.1"

task tests, "Run the macroset tests":
  withDir "tests":
    exec "nim c -r test_collections"

task docs, "Make docs":
  exec "nim doc -o:./docs/collections.html ./src/collections.nim"