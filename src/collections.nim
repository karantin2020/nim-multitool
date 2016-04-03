template map_fn*(name: untyped): untyped =
  
  ## Template for generic map proc that processes any
  ## collection of data with procs `[]` and `len`.
  ## Returns data type T
  ## Map proc with long defined callback proc
  ## fn callback takes three arguments:
  ##   x:N       current value
  ##   i:int     current index in collection
  ##   ld:var T  processed collection
  ## return data type is N
  proc name*[T,N](d: T, fn: proc(x:N, i:int, ld: T): N {.closure.}): T =
    result = d
    for i in 0..d.len-1: 
      result[i] = fn(d[i],i,d)
    return result
  
template map_fn_short*(name: untyped): untyped =
  
  ## Template for generic map proc that processes any
  ## collection of data with procs `[]` and `len`.
  ## Returns data type T
  ## Map proc with short defined callback proc
  ## fn callback takes three arguments:
  ##   x:N       current value
  ##   i:int     current index in collection
  ##   return data type is N
  proc name*[T,N](d: T, fn: proc(x:N, i:int): N {.closure.}): T =
    var result = d
    for i in 0..d.len-1: 
      result[i] = fn(d[i],i)
    return result

map_fn(map)
map_fn(each)
map_fn(forEach)
map_fn_short(map)
map_fn_short(each)
map_fn_short(forEach)
  
proc reduce*[T,N](d: T, fn: proc(y:N,x:N,i:int,ld:T): N {.closure.}): N =
    var res: N
    for i in 0..d.len-1: 
      res = fn(res,d[i],i,d)
    return res
    
proc reduce*[T,N](d: T, fn: proc(y:N,x:N,i:int): N {.closure.}): N =
    var res: N
    for i in 0..d.len-1: 
      res = fn(res,d[i],i)
    return res
    
proc reduce*[T,N](d: T, fn: proc(y:N,x:N): N {.closure.}): N =
    var res: N
    for i in 0..d.len-1: 
      res = fn(res,d[i])
    return res