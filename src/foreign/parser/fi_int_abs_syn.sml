(*
 * Foreign Interface parser: Internal abstract syntax
 *
 * Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 * 
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 * IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 * TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 * PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 * TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * $Log: fi_int_abs_syn.sml,v $
 * Revision 1.2  1997/08/22 10:27:56  brucem
 * Automatic checkin:
 * changed attribute _comment to ' *  '
 *
 *
 *)

require "fi_abs_syntax";

(* FI Internal Abstract Syntax:
   Extra structures and function used for constructing abstract syntax *)

signature FI_INT_ABS_SYN =
  sig

    structure FIAbsSyntax : FI_ABS_SYNTAX

    (* Information for making new types from simpler ones *)
    datatype type_info =
      NO_TYPE_INFO
    | AS_POINTER of type_info
    | AS_ARRAY of 
        {dimensions: FIAbsSyntax.expression option, elemTypeInfo: type_info}
    | AS_FUNCTION of
        {returnTypeInfo : type_info,
         params: {name : string option, paramType : FIAbsSyntax.types} list }

    (* insertTypeInfo a b
       Goes through `a' until it finds a NO_TYPE_INFO, and replaces
       this with `b'.  *)
    val insertTypeInfo : type_info * type_info -> type_info

    (* Make a new type using type info *)
    val makeType : FIAbsSyntax.types * type_info -> FIAbsSyntax.types

    (* Make new simple types e.g. unsigned int *)
    val makeSignedType : FIAbsSyntax.types -> FIAbsSyntax.types
    val makeUnsignedType : FIAbsSyntax.types -> FIAbsSyntax.types
    val makeLongType : FIAbsSyntax.types -> FIAbsSyntax.types
    val makeShortType : FIAbsSyntax.types -> FIAbsSyntax.types

    (* Combine a type and declarator to make a struct/union field *)
    val makeField :
      FIAbsSyntax.types * {name :string, typeInfo :type_info}
      -> FIAbsSyntax.field

    (* Combine type and declarator information to make a declaration *)
    val makeDeclaration :
      FIAbsSyntax.types *
      {name : string, typeInfo : type_info} ->
      FIAbsSyntax.declaration

    (* Combine type and declarator information to make a typedef declaration *)
    val makeTypedef : 
      FIAbsSyntax.types *
      {name : string, typeInfo : type_info } ->
      FIAbsSyntax.declaration

    (* Combine type, declarator and value to make a constant declaration *)
    val makeConst :
      FIAbsSyntax.types *
      {name : string, typeInfo : type_info } *
      FIAbsSyntax.expression ->
      FIAbsSyntax.declaration

  end
