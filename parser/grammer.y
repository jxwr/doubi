%{

package parser

import (
       "github.com/jxwr/doubi/ast"
       "github.com/jxwr/doubi/token"
)

%}

// fields inside this union end up as the fields in a structure known
// as ${PREFIX}SymType, of which a reference is passed to the lexer.
%union {
    node ast.Node
    expr ast.Expr
    expr_list []ast.Expr
    stmt ast.Stmt
    stmt_list []ast.Stmt
    lit string
}

%type <expr> expr ident basiclit
%type <expr> paren_expr selector_expr index_expr slice_expr 
%type <expr> call_expr unary_expr binary_expr prog
%type <expr_list> expr_list

%type <stmt> stmt expr_stmt send_stmt incdec_stmt assign_stmt go_stmt
%type <stmt_list> stmt_list

%token <lit> EOF EOL COMMENT
%token <lit> IDENT INT FLOAT STRING CHAR 
%token <lit> SHL SHR AND_NOT 
%token <lit> ADD_ASSIGN SUB_ASSIGN MUL_ASSIGN QUO_ASSIGN REM_ASSIGN
%token <lit> AND_ASSIGN OR_ASSIGN XOR_ASSIGN SHL_ASSIGN SHR_ASSIGN AND_NOT_ASSIGN
%token <lit> LAND LOR ARROW INC DEC EQL
%token <lit> NEQ LEQ GEQ DEFINE ELLIPSIS ADD SUB MUL QUO REM AND OR XOR
%token <lit> LSS GTR ASSIGN NOT 
%token <lit> LPAREN LBRACK LBRACE COMMA PERIOD RPAREN RBRACK RBRACE
%token <lit> SEMICOLON COLON

%token <lit> BREAK CASE CHAN CONTINUE CONST
%token <lit> DEFAULT DEFER ELSE FALLTHROUGH FOR
%token <lit> FUNC GO GOTO IF IMPORT INTERFACE MAP PACKAGE RANGE RETURN 
%token <lit> SELECT STRUCT SWITCH TYPE VAR 

%left LBRACK
%left PERIOD 
%left SHL SHR AND_NOT 
%left OR
%left AND XOR
%left ADD SUB
%left MUL QUO REM
%left NEQ LEQ GEQ 
%left LSS GTR
%left NOT 
%left LAND LOR ARROW INC DEC EQL
%left LPAREN
%left UMINUS

%right ASSIGN ADD_ASSIGN SUB_ASSIGN MUL_ASSIGN QUO_ASSIGN REM_ASSIGN AND_ASSIGN OR_ASSIGN XOR_ASSIGN SHL_ASSIGN SHR_ASSIGN AND_NOT_ASSIGN DEFINE

%start prog

%%

ident : IDENT				{ $$ = ast.Ident{0, $1} }

basiclit : INT				{ $$ = ast.BasicLit{0, token.INT, $1} }
	 | FLOAT			{ $$ = ast.BasicLit{0, token.FLOAT, $1} }
	 | STRING 			{ $$ = ast.BasicLit{0, token.STRING, $1} }
	 | CHAR				{ $$ = ast.BasicLit{0, token.CHAR, $1} }

paren_expr : LPAREN expr RPAREN		{ $$ = ast.ParenExpr{0, $2, 0} }

selector_expr : expr PERIOD ident      	{ $$ = ast.SelectorExpr{$1, $3.(ast.Ident)} }

slice_expr : expr LBRACK expr COLON expr RBRACK	
	     { $$ = ast.SliceExpr{$1, 0, $3, $5, 0} }

index_expr : expr LBRACK expr RBRACK    
	     { $$ = ast.IndexExpr{$1, 0, $3, 0} }

expr_list : expr  	      		{ $$ = []ast.Expr{$1} }
	  | expr_list COMMA expr	{ $$ = append($1, $3) }

call_expr : expr LPAREN expr_list RPAREN  { $$ = ast.CallExpr{$1, 0, $3, 0} }

unary_expr : SUB expr %prec UMINUS	  { $$ = ast.UnaryExpr{0, token.SUB, $2 } }

binary_expr : expr ADD expr 		  { $$ = ast.BinaryExpr{$1, 0, token.ADD, $3 } }
            | expr SUB expr		  { $$ = ast.BinaryExpr{$1, 0, token.SUB, $3 } }
            | expr MUL expr		  { $$ = ast.BinaryExpr{$1, 0, token.MUL, $3 } }
            | expr QUO expr		  { $$ = ast.BinaryExpr{$1, 0, token.QUO, $3 } }
            | expr REM expr		  { $$ = ast.BinaryExpr{$1, 0, token.REM, $3 } }
            | expr AND expr		  { $$ = ast.BinaryExpr{$1, 0, token.AND, $3 } }
            | expr OR expr		  { $$ = ast.BinaryExpr{$1, 0, token.OR, $3 } }

expr : ident
     | basiclit
     | paren_expr
     | selector_expr
     | index_expr
     | slice_expr
     | call_expr
     | unary_expr
     | binary_expr

/// stmts

expr_stmt : expr			{ $$ = ast.ExprStmt{$1} }

send_stmt : expr ARROW expr		{ $$ = ast.SendStmt{$1, 0, $3} }

incdec_stmt : expr INC 			{ $$ = ast.IncDecStmt{$1, 0, token.INC} }
	    | expr DEC			{ $$ = ast.IncDecStmt{$1, 0, token.DEC } }

assign_stmt : expr_list ASSIGN expr_list       		{ $$ = ast.AssignStmt{$1, 0, token.ASSIGN, $3} }
	    | expr_list ADD_ASSIGN expr_list		{ $$ = ast.AssignStmt{$1, 0, token.ADD_ASSIGN, $3} }
	    | expr_list SUB_ASSIGN expr_list		{ $$ = ast.AssignStmt{$1, 0, token.SUB_ASSIGN, $3} }
	    | expr_list MUL_ASSIGN expr_list		{ $$ = ast.AssignStmt{$1, 0, token.MUL_ASSIGN, $3} }
	    | expr_list QUO_ASSIGN expr_list		{ $$ = ast.AssignStmt{$1, 0, token.QUO_ASSIGN, $3} }
	    | expr_list REM_ASSIGN expr_list		{ $$ = ast.AssignStmt{$1, 0, token.REM_ASSIGN, $3} }
	    | expr_list AND_ASSIGN expr_list		{ $$ = ast.AssignStmt{$1, 0, token.AND_ASSIGN, $3} }
	    | expr_list OR_ASSIGN expr_list		{ $$ = ast.AssignStmt{$1, 0, token.OR_ASSIGN, $3} }
	    | expr_list XOR_ASSIGN expr_list		{ $$ = ast.AssignStmt{$1, 0, token.XOR_ASSIGN, $3} }
	    | expr_list SHL_ASSIGN expr_list		{ $$ = ast.AssignStmt{$1, 0, token.SHL_ASSIGN, $3} }
	    | expr_list SHR_ASSIGN expr_list		{ $$ = ast.AssignStmt{$1, 0, token.SHR_ASSIGN, $3} }
	    | expr_list AND_NOT_ASSIGN expr_list	{ $$ = ast.AssignStmt{$1, 0, token.AND_NOT_ASSIGN, $3} }

go_stmt : GO call_expr
	  { $$ = ast.GoStmt{0, $2.(ast.CallExpr)} }

/*
return_stmt : RETURN expr_list

branch_stmt : BREAK | CONTINUE ;

block_stmt : LBRACE stmt_list RBRACE ;

if_stmt : IF expr block_stmt ELSE stmt

case_stmt : CASE expr_list COLON stmt_list

switch_stmt : SWITCH stmt block_stmt

select_stmt : SELECT block_stmt

for_stmt : FOR stmt SEMICOLON expr SEMICOLON stmt block_stmt

range_stmt : FOR expr SEMICOLON expr ASSIGN expr block_stmt
*/

stmt : expr_stmt
     | send_stmt
     | incdec_stmt
     | assign_stmt
     | go_stmt
/*
     | return_stmt
     | branch_stmt
     | if_stmt
     | case_stmt
     | switch_stmt
     | for_stmt
     | range_stmt
*/

stmt_list : stmt			{ $$ = []ast.Stmt{$1} }
	  | stmt_list EOL stmt		{ $$ = append($1, $3) }
	  | stmt_list SEMICOLON stmt	{ $$ = append($1, $3) }

/// program

prog : stmt_list EOL
       { __yyfmt__.Printf("%#v\n", $1) }
     ;
