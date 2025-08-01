---@meta no-require
-- Copyright (c) 2018. tangzx(love.tangzx@qq.com)
--
-- Licensed under the Apache License, Version 2.0 (the "License"); you may not
-- use this file except in compliance with the License. You may obtain a copy of
-- the License at
--
-- http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
-- WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
-- License for the specific language governing permissions and limitations under
-- the License.

---
--- Calls error if the value of its argument `v` is false (i.e., **nil** or
--- **false**); otherwise, returns all its arguments. In case of error,
--- `message` is the error object; when absent, it defaults to "assertion
--- failed!"
---@generic T, T1
---@param v T
---@param ... T1...
---@return std.NotNull<T>, T1...
function assert(v, ...) end

---@alias std.collectgarbage_opt
---|>"collect" # performs a full garbage-collection cycle. This is the default option.
---| "stop" # stops automatic execution of the garbage collector. The collector will run only when explicitly invoked, until a call to restart it.
---| "restart" # restarts automatic execution of the garbage collector.
---| "count" # returns the total memory in use by Lua in Kbytes. The value has a fractional part, so that it multiplied by 1024 gives the exact number of bytes in use by Lua (except for overflows).
---| "step" # performs a garbage-collection step. The step "size" is controlled by `arg`. With a zero value, the collector will perform one basic (indivisible) step. For non-zero values, the collector will perform as if Lua had allocated that amount of memory (in KBytes). Returns true if the step finished a collection cycle.
---| "setpause" # sets `arg` as the new value for the *pause* of the collector (see §2.5). Returns the previous value for *pause*.
---| "setstepmul" # sets `arg` as the new value for the *step multiplier* of the collector (see §2.5). Returns the previous value for *step*.
---| "incremental" # Change the collector mode to incremental. This option can be followed by three numbers: the garbage-collector pause, the step multiplier, and the step size.
---| "generational" # Change the collector mode to generational. This option can be followed by two numbers: the garbage-collector minor multiplier and the major multiplier.
---| "isrunning" # returns a boolean that tells whether the collector is running (i.e., not stopped).

---
--- This function is a generic interface to the garbage collector. It performs
--- different functions according to its first argument, `opt`:
---
--- **"collect"**: performs a full garbage-collection cycle. This is the default
--- option.
--- **"stop"**: stops automatic execution of the garbage collector. The
--- collector will run only when explicitly invoked, until a call to restart it.
--- **"restart"**: restarts automatic execution of the garbage collector.
--- **"count"**: returns the total memory in use by Lua in Kbytes. The value has
--- a fractional part, so that it multiplied by 1024 gives the exact number of
--- bytes in use by Lua (except for overflows).
--- **"step"**: performs a garbage-collection step. The step "size" is
--- controlled by `arg`. With a zero value, the collector will perform one basic
--- (indivisible) step. For non-zero values, the collector will perform as if
--- that amount of memory (in KBytes) had been allocated by Lua. Returns
--- **true** if the step finished a collection cycle.
--- **"setpause"**: sets `arg` as the new value for the *pause* of the collector
--- (see §2.5). Returns the previous value for *pause`.
--- **"incremental"**: Change the collector mode to incremental. This option can
--- be followed by three numbers: the garbage-collector pause, the step
--- multiplier, and the step size.
--- **"generational"**: Change the collector mode to generational. This option
--- can be followed by two numbers: the garbage-collector minor multiplier and
--- the major multiplier.
--- **"isrunning"**: returns a boolean that tells whether the collector is
--- running (i.e., not stopped).
---@param opt? std.collectgarbage_opt
---@param ... any
---@return any
function collectgarbage(opt, ...) end

---
--- Opens the named file and executes its contents as a Lua chunk. When called
--- without arguments, `dofile` executes the contents of the standard input
--- (`stdin`). Returns all values returned by the chunk. In case of errors,
--- `dofile` propagates the error to its caller (that is, `dofile` does not run
--- in protected mode).
---@param filename? string
---@return table
function dofile(filename) end

---
--- Terminates the last protected function called and returns `message` as the
--- error object. Function `error` never returns. Usually, `error` adds some
--- information about the error position at the beginning of the message, if the
--- message is a string. The `level` argument specifies how to get the error
--- position. With level 1 (the default), the error position is where the
--- `error` function was called. Level 2 points the error to where the function
--- that called `error` was called; and so on. Passing a level 0 avoids the
--- addition of error position information to the message.
---@param message any
---@param level? integer
function error(message, level) end

---
--- A global variable (not a function) that holds the global environment. Lua
--- itself does not use this variable; changing its value does not affect any
--- environment, nor vice versa.
---@type global
_G = {}

---
--- If `object` does not have a metatable, returns **nil**. Otherwise, if the
--- object's metatable has a `"__metatable"` field, returns the associated
--- value. Otherwise, returns the metatable of the given object.
---@param object any
---@return any
function getmetatable(object) end

---
--- Returns three values (an iterator function, the table `t`, and 0) so that
--- the construction
--- > `for i,v in ipairs(t) do` *body* `end`
--- will iterate over the key–value pairs (1,`t[1]`), (2,`t[2]`), ..., up to
--- the first absent index.
---@generic V
---@param t V[] | table<int, V> | {[int]: V}
---@return fun(tbl: any):int, V
function ipairs(t) end

---@alias std.loadmode
---| "b" # only binary chunks
---| "t" # only text chunks
---| "bt" # both binary and text

---
--- Loads a chunk.
--- If `chunk` is a string, the chunk is this string. If `chunk` is a function,
--- `load` calls it repeatedly to get the chunk pieces. Each call to `chunk`
--- must return a string that concatenates with previous results. A return of
--- an empty string, **nil**, or no value signals the end of the chunk.
---
--- If there are no syntactic errors, returns the compiled chunk as a function;
--- otherwise, returns **nil** plus the error message.
---
--- If the resulting function has upvalues, the first upvalue is set to the
--- value of `env`, if that parameter is given, or to the value of the global
--- environment. Other upvalues are initialized with **nil**. (When you load a
--- main chunk, the resulting function will always have exactly one upvalue, the
--- _ENV variable. However, when you load a binary chunk created from a
--- function (see string.dump), the resulting function can have an arbitrary
--- number of upvalues.) All upvalues are fresh, that is, they are not shared
--- with any other function.
---
--- `chunkname` is used as the name of the chunk for error messages and debug
--- information. When absent, it defaults to `chunk`, if `chunk` is a string,
--- or to "=(`load`)" otherwise.
---
--- The string `mode` controls whether the chunk can be text or binary (that is,
--- a precompiled chunk). It may be the string "b" (only binary chunks), "t"
--- (only text chunks), or "bt" (both binary and text). The default is "bt".
---
--- Lua does not check the consistency of binary chunks. Maliciously crafted
--- binary chunks can crash the interpreter.
---@param chunk (fun(...:any):string) | string
---@param chunkname? string
---@param mode? std.loadmode
---@param env? table
---@return function? chunk
---@return string?   error_message
---@nodiscard
function load(chunk, chunkname, mode, env) end


---
---Loads a chunk from the given string.
---
---
---@version 5.1, JIT
---@param text       string
---@param chunkname? string
---@return function? chunk
---@return string?   error_message
---@nodiscard
function loadstring(text, chunkname) end

---
--- Similar to `load`, but gets the chunk from file `filename` or from the
--- standard input, if no file name is given.
---@overload fun()
---@param filename string
---@param mode? string
---@param env? any
---@return function? chunk
---@return string? error_message
function loadfile(filename, mode, env) end

---@version 5.1, JIT
---@param proxy boolean|table|userdata
---@return userdata
function newproxy(proxy) end

---@version 5.1, JIT
---
---Creates a module.
---
---
---@param name string
---@param ...  any
function module(name, ...) end

---
--- Allows a program to traverse all fields of a table. Its first argument is
--- a table and its second argument is an index in this table. `next` returns
--- the next index of the table and its associated value. When called with
--- **nil** as its second argument, `next` returns an initial index and its
--- associated value. When called with the last index, or with **nil** in an
--- empty table, `next` returns **nil**. If the second argument is absent, then
--- it is interpreted as **nil**. In particular, you can use `next(t)` to check
--- whether a table is empty.
---
--- The order in which the indices are enumerated is not specified, *even for
--- numeric indices*. (To traverse a table in numerical order, use a numerical
--- **for**.)
---
--- The behavior of `next` is undefined if, during the traversal, you assign
--- any value to a non-existent field in the table. You may however modify
--- existing fields. In particular, you may set existing fields to nil.
---@generic K, V
---@overload fun(table:table<K, V>):K?,V?
---@param table table<K, V> | V[] | {[K]: V}
---@param index? K
---@return K?, V?
function next(table, index) end

---
--- If `t` has a metamethod `__pairs`, calls it with `t` as argument and returns
--- the first three results from the call.
---
--- Otherwise, returns three values: the `next` function, the table `t`, and
--- **nil**, so that the construction
--- `for k,v in pairs(t) do *body* end`
--- will iterate over all key–value pairs of table `t`.
---
--- See function `next` for the caveats of modifying the table during its
--- traversal.
---@generic K, V
---@param t table<K, V> | V[] | {[K]: V}
---@return fun(tbl: any):K, V
function pairs(t) end
---
--- Calls function `f` with the given arguments in *protected mode*. This
--- means that any error inside `f` is not propagated; instead, `pcall` catches
--- the error and returns a status code. Its first result is the status code (a
--- boolean), which is true if the call succeeds without errors. In such case,
--- `pcall` also returns all results from the call, after this first result. In
--- case of any error, `pcall` returns **false** plus the error message.
---@generic T, R, R1
---@param f fun(...: T...): R1, R...
---@param ... T...
---@return boolean, R1|string, R...
function pcall(f, ...) end

---
--- Receives any number of arguments, and prints their values to `stdout`,
--- using the `tostring` function to convert them to strings. `print` is not
--- intended for formatted output, but only as a quick way to show a value,
--- for instance for debugging. For complete control over the output, use
--- `string.format` and `io.write`.
function print(...) end

---
--- Checks whether `v1` is equal to `v2`, without the `__eq` metamethod. Returns
--- a boolean.
---@param v1 any
---@param v2 any
---@return boolean
function rawequal(v1, v2) end

---
--- Gets the real value of `table[index]`, the `__index` metamethod. `table`
--- must be a table; `index` may be any value.
---@generic T, K
---@param table T
---@param index std.ConstTpl<K>
---@return std.RawGet<T, K>
function rawget(table, index) end

---@version >5.2
---
--- Returns the length of the object `v`, which must be a table or a string, without
--- invoking any metamethod. Returns an integer number.
---@param v string|table
---@return integer
function rawlen(v) end

---
--- Sets the real value of `table[index]` to `value`, without invoking the
--- `__newindex` metamethod. `table` must be a table, `index` any value
--- different from **nil** and NaN, and `value` any Lua value.
---@param table table
---@param index any
---@param value any
function rawset(table, index, value) end

---
--- Loads the given module. The function starts by looking into the
--- 'package.loaded' table to determine whether `modname` is already
--- loaded. If it is, then `require` returns the value stored at
--- `package.loaded[modname]`. Otherwise, it tries to find a *loader* for
--- the module.
---
--- To find a loader, `require` is guided by the `package.searchers` sequence.
--- By changing this sequence, we can change how `require` looks for a module.
--- The following explanation is based on the default configuration for
--- `package.searchers`.
---
--- First `require` queries `package.preload[modname]`. If it has a value,
--- this value (which should be a function) is the loader. Otherwise `require`
--- searches for a Lua loader using the path stored in `package.path`. If
--- that also fails, it searches for a C loader using the path stored in
--- `package.cpath`. If that also fails, it tries an *all-in-one* loader (see
--- `package.loaders`).
---
--- Once a loader is found, `require` calls the loader with a two argument:
--- `modname` and an extra value dependent on how it got the loader. (If the
--- loader came from a file, this extra value is the file name.) If the loader
--- returns any non-nil value, require assigns the returned value to
--- `package.loaded[modname]`. If the loader does not return a non-nil value and
--- has not assigned any value to `package.loaded[modname]`, then `require`
--- assigns true to this entry. In any case, require returns the final value of
--- `package.loaded[modname]`.
---
--- If there is any error loading or running the module, or if it cannot find
--- any loader for the module, then `require` raises an error.
---@param modname string
---@return any
function require(modname) end

---
--- If `index` is a number, returns all arguments after argument number
--- `index`. a negative number indexes from the end (-1 is the last argument).
--- Otherwise, `index` must be the string "#", and `select` returns
--- the total number of extra arguments it received.
---@generic T, Num: integer | '#'
---@param index std.ConstTpl<Num>
---@param ... T...
---@return std.Select<T..., Num>
function select(index, ...) end


---@class std.metatable
---@field __mode? 'v'|'k'|'kv'
---@field __metatable? any
---@field __tostring? (fun(t):string)
---@field __gc? fun(t)
---@field __add? fun(t1,t2):any
---@field __sub? fun(t1,t2):any
---@field __mul? fun(t1,t2):any
---@field __div? fun(t1,t2):any
---@field __mod? fun(t1,t2):any
---@field __pow? fun(t1,t2):any
---@field __unm? fun(t):any
---@field __idiv? fun(t1,t2):any
---@field __band? fun(t1,t2):any
---@field __bor? fun(t1,t2):any
---@field __bxor? fun(t1,t2):any
---@field __bnot? fun(t):any
---@field __shl? fun(t1,t2):any
---@field __shr? fun(t1,t2):any
---@field __concat? fun(t1,t2):any
---@field __len? fun(t):integer
---@field __eq? fun(t1,t2):boolean
---@field __lt? fun(t1,t2):boolean
---@field __le? fun(t1,t2):boolean
---@field __index? table|fun(t,k):any
---@field __newindex? table|fun(t,k,v)
---@field __call? fun(t,...): any...
---@field __pairs? fun(t):((fun(t,k,v):any,any),any,any)
---@field __close? fun(t,errobj):any

--NOTE: The actual implementation of setmetatable is provided by the language server

---
--- Sets the metatable for the given table. (To change the metatable of other
--- types from Lua code, you must use the debug library.) If `metatable`
--- is **nil**, removes the metatable of the given table. If the original
--- metatable has a `"__metatable"` field, raises an error.
---
--- This function returns `table`.
---@param table table
---@param metatable std.metatable|table|nil
---@return table
function setmetatable(table, metatable) end

---
--- When called with no `base`, `tonumber` tries to convert its argument to a
--- number. If the argument is already a number or a string convertible to a
--- number, then `tonumber` returns this number; otherwise, it returns **nil**.
---
--- The conversion of strings can result in integers or floats, according to the
--- lexical conventions of Lua. (The string may have leading and trailing
--- spaces and a sign.)
---
--- When called with `base`, then e must be a string to be interpreted as an
--- integer numeral in that base. The base may be any integer between 2 and 36,
--- inclusive. In bases above 10, the letter 'A' (in either upper or lower case)
--- represents 10, 'B' represents 11, and so forth, with 'Z' representing 35. If
--- the string `e` is not a valid numeral in the given base, the function
--- returns **nil**.
---@overload fun(e: string, base: integer):integer?
---@param e any
---@return number?
---@nodiscard
function tonumber(e) end

---
--- Receives a value of any type and converts it to a string in a human-readable
--- format. (For complete control of how numbers are converted, use `string
--- .format`).
---
--- If the metatable of `v` has a `__tostring` field, then `tostring` calls
--- the corresponding value with `v` as argument, and uses the result of the
--- call as its result.
---@param v any
---@return string
function tostring(v) end

---@alias std.type
---| "nil"
---| "number"
---| "string"
---| "boolean"
---| "table"
---| "function"
---| "thread"
---| "userdata"

---
--- Returns the type of its only argument, coded as a string. The possible
--- results of this function are "`nil`" (a string, not the value **nil**),
--- "`number`", "`string`", "`boolean`", "`table`", "`function`", "`thread`",
--- and "`userdata`".
---@param v any
---@return std.type type
function type(v) end

---
--- A global variable (not a function) that holds a string containing the
--- running Lua version. The current value of this variable is "`Lua 5.3`".
_VERSION = "Lua 5.4"

---
--- This function is similar to `pcall`, except that it sets a new message
--- handler `msgh`.
---@generic T, R
---@param f fun(...:T...): R...
---@param msgh fun(err:string):void
---@param ... T...
---@return boolean, R...
function xpcall(f, msgh, ...) end

---@version 5.1, JIT
---@generic T, Start: integer, End: integer
---@param i? std.ConstTpl<Start>
---@param j? std.ConstTpl<End>
---@param list T
---@return std.Unpack<T, Start, End>
function unpack(list, i, j) end

---@version > 5.4
---@param message string
function warn(message) end

---@type string[]
arg = {}

--- This is an incorrect annotation, but truly supporting _ENV would completely break the variable analysis path.
--- For now, let's treat it as a global variable.
---@version > 5.3
---@type global
_ENV = {}


---@version 5.1, JIT
--- Sets the environment for the specified function.
---@param f function|integer The function for which the environment is to be set.
---@param env table The environment table to assign to the function.
function setfenv(f, env) end

---@version 5.1, JIT
--- Retrieves the environment table of the specified function.
---@param f function|integer The function whose environment is to be retrieved.
---@return table The environment table associated with the given function.
function getfenv(f) end
