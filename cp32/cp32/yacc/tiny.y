/****************************************************/
/* File: tiny.y                                     */
/* The TINY Yacc/Bison specification file           */
/* Compiler Construction: Principles and Practice   */
/* Kenneth C. Louden                                */
/****************************************************/
%{
#define YYPARSER /* distinguishes Yacc output from other code files */

#include "globals.h"
#include "util.h"
#include "scan.h"
#include "parse.h"

#define YYSTYPE TreeNode *
static char * savedName; /* for use in assignments */
static int savedLineNo;  /* ditto */
static TreeNode * savedTree; /* stores syntax tree for later return */

%}

%token IF THEN ELSE ENDIF ENDWHILE ENDDO REPEAT UNTIL READ WRITE WHILE DO FOR TO DOWNTO
%token ID NUM 
%token ASSIGN EQ LT PLUS MINUS TIMES OVER MOD LPAREN RPAREN SEMI
%token ERROR 
%right DO
%right WHILE
%% /* Grammar for TINY */

program     : stmt_seq
                 { savedTree = $1;} 
            ;
stmt_seq    : stmt_seq stmt
                 { YYSTYPE t = $1;
                   if (t != NULL)
                   { while (t->sibling != NULL)
                        t = t->sibling;
                     t->sibling = $2;
                     $$ = $1; }
                     else $2 = $2;
                 }
            | stmt  { $$ = $1; }
            ;

while_stmt: WHILE exp DO stmt_seq ENDWHILE
                 { $$ = newStmtNode(WhileK);
                   $$->child[0] = $2;
                   $$->child[1] = $4;
		}
            ;
do_stmt	    : DO stmt_seq WHILE exp 
                 { $$ = newStmtNode(DoK);
                   $$->child[0] = $2;
                   $$->child[1] = $4;
                 }
            ;
for_stmt    :FOR assign_stmt TO simple_exp DO stmt_seq ENDDO
		{$$ = newStmtNode(ForK);
		 $$->child[0] = $2;
		 $$->child[1] = $4;
		 $$->child[2] = $6;
		}
            |FOR assign_stmt DOWNTO simple_exp DO stmt_seq ENDDO
		{$$ = newStmtNode(ForK);
		 $$->child[0] = $2;
		 $$->child[1] = $4;
		 $$->child[2] = $6;
		}
	    ;
stmt        : if_stmt { $$ = $1; }
            | repeat_stmt { $$ = $1; }
            | assign_stmt SEMI{ $$ = $1; }
            | read_stmt SEMI { $$ = $1; }
            | write_stmt SEMI{ $$ = $1; }
            | error  { $$ = NULL; }
            | while_stmt  { $$ = $1; }
	    | do_stmt {$$ = $1;}
	    | for_stmt{$$ = $1;}
            ;
if_stmt     : IF exp THEN stmt_seq ENDIF
                 { $$ = newStmtNode(IfK);
                   $$->child[0] = $2;
                   $$->child[1] = $4;
                 }
            | IF exp THEN stmt_seq ELSE stmt_seq ENDIF
                 { $$ = newStmtNode(IfK);
                   $$->child[0] = $2;
                   $$->child[1] = $4;
                   $$->child[2] = $6;
                 }
            ;
repeat_stmt : REPEAT stmt_seq UNTIL exp
                 { $$ = newStmtNode(RepeatK);
                   $$->child[0] = $2;
                   $$->child[1] = $4;
                 }
            ;
assign_stmt : ID { savedName = copyString(tokenString);
                   savedLineNo = lineno; }
              ASSIGN exp 
                 { $$ = newStmtNode(AssignK);
                   $$->child[0] = $4;
                   $$->attr.name = savedName;
                   $$->lineno = savedLineNo;
                 }
            ;
read_stmt   : READ ID 
                 { $$ = newStmtNode(ReadK);
                   $$->attr.name =
                     copyString(tokenString);
                 }
            ;
write_stmt  : WRITE exp
                 { $$ = newStmtNode(WriteK);
                   $$->child[0] = $2;
                 }
            ;
exp         : simple_exp LT simple_exp
                 { $$ = newExpNode(OpK);
                   $$->child[0] = $1;
                   $$->child[1] = $3;
                   $$->attr.op = LT;
                 }
            | simple_exp EQ simple_exp
                 { $$ = newExpNode(OpK);
                   $$->child[0] = $1;
                   $$->child[1] = $3;
                   $$->attr.op = EQ;
                 }
            | simple_exp { $$ = $1; }
            ;
simple_exp  : simple_exp PLUS term 
                 { $$ = newExpNode(OpK);
                   $$->child[0] = $1;
                   $$->child[1] = $3;
                   $$->attr.op = PLUS;
                 }
            | simple_exp MINUS term 
                 { $$ = newExpNode(OpK);
                   $$->child[0] = $1;
                   $$->child[1] = $3;
                   $$->attr.op = MINUS;
                 } 
            | term { $$ = $1; }
            ;
term        : term TIMES factor 
                 { $$ = newExpNode(OpK);
                   $$->child[0] = $1;
                   $$->child[1] = $3;
                   $$->attr.op = TIMES;
                 }
            | term OVER factor 
                 { $$ = newExpNode(OpK);
                   $$->child[0] = $1;
                   $$->child[1] = $3;
                   $$->attr.op = OVER;
                 }
            | term MOD factor 
                 { $$ = newExpNode(OpK);
                   $$->child[0] = $1;
                   $$->child[1] = $3;
                   $$->attr.op = MOD;
                 }
            | factor { $$ = $1; }
            ;
factor      : LPAREN exp RPAREN
                 { $$ = $2; }
            | NUM
                 { $$ = newExpNode(ConstK);
                   $$->attr.val = atoi(tokenString);
                 }
            | ID { $$ = newExpNode(IdK);
                   $$->attr.name =
                         copyString(tokenString);
                 }
            | error { $$ = NULL; }
            ;

%%

int yyerror(char * message)
{ fprintf(listing,"Syntax error at line %d: %s\n",lineno,message);
  fprintf(listing,"Current token: ");
  printToken(yychar,tokenString);
  Error = TRUE;
  return 0;
}


TreeNode * parse(void)
{ yyparse();
  return savedTree;
}

