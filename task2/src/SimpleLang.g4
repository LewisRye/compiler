grammar SimpleLang;

prog : dec+ EOF;

dec
    : typed_idfr LParen (vardec+=typed_idfr(Comma vardec+=typed_idfr)*)? RParen body
;

typed_idfr
    : type Idfr (Comma)?
;

type
    : IntType | BoolType | UnitType
;

body
    : LBrace ene+=exp (Semicolon ene+=exp)* RBrace
;

block
    : LBrace ene+=exp (Semicolon ene+=exp)* RBrace
;

exp
    : Idfr                                                  #IdExpr
    | Idfr Assign exp                                       #ReassignExpr
    | type Idfr Assign exp                                  #AssignExpr
    | IntLit                                                #IntExpr
    | BoolLit                                               #BoolExpr
    | LParen exp binop exp RParen                           #BinOpExpr
    | Idfr LParen (args+=exp (Comma args+=exp)*)? RParen    #InvokeExpr
    | block                                                 #BlockExpr
    | If exp Then block Else block                          #IfExpr
    | While exp Do block                                    #WhileExpr
    | Repeat block Until exp                                #RepeatExpr
    | Print exp                                             #PrintExpr
    | Space                                                 #SpaceExpr
    | NewLine                                               #NewLineExpr
    | Skip                                                  #SkipExpr
;

binop
    : Eq              #EqBinop
    | Less            #LessBinop
    | More            #MoreBinop
    | LessEq          #LessEqBinop
    | MoreEq          #MoreEqBinop
    | Plus            #PlusBinop
    | Minus           #MinusBinop
    | Times           #TimesBinop
    | Divide          #DivideBinop
    | And             #AndBinop
    | Or              #OrBinop
    | Xor             #XorBinop
;

LParen : '(' ;
Comma : ',' ;
RParen : ')' ;
LBrace : '{' ;
Semicolon : ';' ;
RBrace : '}' ;

Eq : '==' ;
Less : '<' ;
More : '>' ;
LessEq : '<=' ;
MoreEq : '>=' ;

Plus : '+' ;
Times : '*' ;
Minus : '-' ;
Divide : '/' ;

And : '&' ;
Or : '|' ;
Xor : '^' ;

Assign : ':=' ;

Print : 'print' ;
Space : 'space' ;
NewLine : 'newline' ;
Skip : 'skip' ;
If : 'if' ;
Then : 'then' ;
Else : 'else' ;
While : 'while' ;
Do : 'do' ;
Repeat : 'repeat' ;
Until : 'until' ;

IntType : 'int' ;
BoolType : 'bool' ;
UnitType : 'unit' ;

BoolLit : 'true' | 'false' ;
IntLit : '0' | ('-'? [1-9][0-9]*) ;
Idfr : [a-z][A-Za-z0-9_]* ;
WS : [ \n\r\t]+ -> skip ;