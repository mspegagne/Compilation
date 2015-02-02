(* Description of the lexical analyzer *)

{
  open Ulex (* Ulex contains the type definition of lexical units *)
}

let letter = ['a'-'z''A'-'Z']
let number = ['0'-'9']
let beginComment = "/*"
let endComment = '*'+'/'
let noSlashOrStar = [^'*''/'] 		(* a character which is neither '*' or '/' *)
let listStar = '*'+[^'/']		(* a list of '*' which is not followed by a '/' *)
let listSlash = '/'+[^'*']       	(* a list of '/' which is not followed by a '*' *)
let inComment = (beginComment | noSlashOrStar | listStar | listSlash)*
  
  rule token = parse
    | [' ' '\t']        { token lexbuf }     (* skip blanks *)
    | ['\n' ]           { UL_EOF }	    (* skip end of line *)
    | beginComment inComment endComment  { token lexbuf } (* skip comments *)
    | eof               { UL_EOF }
    | "ou"              { UL_OR }
    | "et"              { UL_AND }
    | "si"              { UL_SI }
    | "alors"           { UL_ALORS }
    | "sinon"           { UL_SINON }
    | "fsi"             { UL_FSI } 
    | '='               { UL_EQUAL }
    | "<>"              { UL_DIFF }
    | '<'               { UL_INF }
    | '>'               { UL_SUP }
    | ">="              { UL_SUPEG }
    | "<="              { UL_INFEG }
    | '('               { UL_PAROPEN }
    | ')'               { UL_PARCLOSE }
    | letter (letter | number)* as lxm { UL_IDENT(lxm) }

