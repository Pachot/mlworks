(*

Result: OK
 
 * Revision Log:
 * -------------
 * $Log: floatarray_iterate.sml,v $
 * Revision 1.2  1997/05/28 11:59:08  jont
 * [Bug #30090]
 * Remove uses of MLWorks.IO
 *
 *  Revision 1.1  1997/01/07  14:38:32  andreww
 *  new unit
 *  [Bug #1818]
 *  floatarray tests
 *
 * 
 *

Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are
met:

1. Redistributions of source code must retain the above copyright
   notice, this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright
   notice, this list of conditions and the following disclaimer in the
   documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*)

val a = MLWorks.Internal.FloatArray.arrayoflist(map real [0,1,2,3,4,5,6,7,8,9])

val b = ref [] : real list ref

fun f x = b := x :: (!b)

val _ = MLWorks.Internal.FloatArray.iterate f a

val _ = case (map floor (!b))
          of [9,8,7,6,5,4,3,2,1,0] => 
            print"Pass\n"
           | _ => print"Fail\n"
