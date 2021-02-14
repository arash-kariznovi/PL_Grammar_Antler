grammar lang;

//////////////
///Parser////
////////////

start : class* ;
class: CLASS classname (EXTENDS classname)* LPAREN (STRING ':' type + ','*)* RPAREN LBRACE state RBRACE ;

state : (emport)*(access)* ;
emport : IMPORT library ;

access : PUBLIC COLOMN exp* | PRIVATE COLOMN exp* | PROTECTED COLOMN exp* ;

exp : function | declaration;

declaration: VAR STRING COLOMN type ('='value)* ;
type: Int | Float | String | Bool;

function : DEF STRING '(' (STRING':'type + ','* )* ')' COLOMN (return)* '=' LBRACE code* (ret)* RBRACE;
return: type;
ret: 'return' value;
code : statement | expr | exception;

exception : TRY LBRACE code* RBRACE CATCH LPAREN condition RPAREN LBRACE code* RBRACE;

expr  : '-' expr | '+' expr
      | '(' expr ')'
      | expr '++' | expr '--'
      | expr ('*' | '/' | 'and') expr
      | expr ('+' | '-' | 'or' ) expr
      | expr '=' expr | expr '=+' expr|expr '=-' expr
      | expr  '==' expr | expr '>=' expr | expr '<=' expr | expr '<' expr | expr '>' expr
      | '--' expr | '++' expr
      | value;


statement : ifstatement | whilestatement | forstatement;

forstatement: FOR LPAREN STRING '<-' '('val COM val')' ('step' val)* RPAREN LBRACE code* RBRACE;

whilestatement: WHILE LPAREN condition RPAREN LBRACE code* RBRACE;

ifstatement: IF LPAREN condition RPAREN LBRACE code* RBRACE
(ELSEIF LPAREN condition RPAREN LBRACE code* RBRACE)?
(ELSE LBRACE code* RBRACE)?;


condition: expr;
library: STRING;
val:INT;
classname: STRING;
value: INT | FLOAT | STRING | BOOL;

//////////////////
/////LEXER///////
////////////////

    // skips tabs, newlines, spaces ...
WS:[\n \t \r]+ -> skip;
WS1:[ \t \r]+ -> skip;


    //key words:
CLASS: 'class';
PUBLIC: 'public';
PRIVATE: 'private';
PROTECTED: 'protected';
IF : 'if';
ELSEIF : 'elseif';
ELSE : 'else';
WHILE: 'while';
IMPORT : 'import';
DEF : 'def';
VAR : 'var';
String: 'String';
Int: 'Int';
Float: 'Float';
Bool: 'Bool';
EXTENDS: 'extends';
FOR : 'for';
TRY : 'try';
CATCH : 'catch';

    //Notations:
LPAREN: '(';
RPAREN: ')';
LBRACE: '{';
RBRACE: '}';
COLOMN: ':';
NEWLINE: '\n';
 DOT: '.';
 COM: ',';



    //Data Types:
        //Boolean
BOOL:'true'|'false';
        //Char
CHAR: ('a'..'z'|'A'..'Z');

        //String
STRING:('a'..'z'|'A'..'Z'|'_')('a'..'z'|'A'..'Z'|'0'..'9'|'_'|'$')('a'..'z'|'A'..'Z'|'0'..'9'|'_'|'$')* ;

        //Integer
INT:'0'..'9'+ ;

        //Float
FLOAT:('0'..'9')+ '.' ('0'..'9')* EXPONENT?
     |'.' ('0'..'9')+ EXPONENT?
     |('0'..'9')+ EXPONENT;
fragment EXPONENT : ('e'|'E') ('+'|'-')? ('0'..'9')+ ;

DATATYPE: BOOL | STRING | INT | FLOAT;


    // Comments
SINGLELINECOMMENT: ('#'(DATATYPE|WS1|DATATYPE)*) -> skip;
//MULTILINECOMMENT: ((NEWLINE|DATATYPE)*'#')? -> skip;





