import unittest, ../src/collections
from future import `=>`
import typetraits, strutils

proc foo(li: int, i: int, le: seq[int]): int =
  return li + li
  
proc foo_short(li: int, i: int): int =
  return li + li
 

proc reduce_cb(j: int, k:int): int =
  return j+k  

suite "Test map procs":
  test "unchangable source data collection with map":
    var s1: seq[int] = @[12,23,34]
    var s2 = s1
    discard map(s1,foo)
    check(s2 == s1)
  
  test "check result of map":
    var s1: seq[int] = @[12,23,34]
    check(map(s1,foo) == @[24,46,68])

  test "check result of each":
    var s1: seq[int] = @[12,23,34]
    check(s1.each(foo) == @[24,46,68])

  test "check result of chained map":
    var s1: seq[int] = @[12,23,34]
    check(s1.map(foo).map(foo) == @[48,92,136])

  test "check result of map with arrow-like cb":
    var s1: seq[int] = @[12,23,34]
    check(s1.map((x:int,i:int)=>x+x) == @[24,46,68])

  test "check map_fn_short_noresult":
    var s1: seq[int] = @[12,23,34]
    var ar1: array[3,int]
    s1.map(proc(x:int,i:int) =
      ar1[i] = x)
    # echo name(type(ar1))
    # echo repr ar1
    check(ar1 == [12,23,34])

suite "Test reduce procs":
  test "unchangable source data collection with reduce":
    var s1: seq[int] = @[12,23,34]
    var s2 = s1
    discard reduce(s1,reduce_cb)
    check(s2 == s1)
  
  test "check result of reduce":
    var s1: seq[int] = @[12,23,34]
    check(s1.reduce(reduce_cb) == 69)

  test "check result of chained map and reduce":
    var s1: seq[int] = @[12,23,34]
    check(s1.map(foo).reduce(reduce_cb) == 138)

suite "Test mutable map procs":
  test "unchangable source data collection with mutable map":
    var s1: seq[string] = @["12","23","34"]
    var s3 = newSeq[int](len s1)
    var s2 = s1
    s1.map((x:string)=>parseInt(x),s3)
    check(s2 == s1)
  
  test "mutate source data with mutable map proc":
    var s1: seq[string] = @["12","23","34"]
    var s3 = newSeq[int](len s1)
    s1.map((x:string)=>parseInt(x),s3)
    check(s3 == @[12,23,34])
  