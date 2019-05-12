/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    IF = 258,
    THEN = 259,
    ELSE = 260,
    ENDIF = 261,
    ENDWHILE = 262,
    ENDDO = 263,
    REPEAT = 264,
    UNTIL = 265,
    READ = 266,
    WRITE = 267,
    WHILE = 268,
    DO = 269,
    FOR = 270,
    TO = 271,
    DOWNTO = 272,
    ID = 273,
    NUM = 274,
    ASSIGN = 275,
    EQ = 276,
    LT = 277,
    PLUS = 278,
    MINUS = 279,
    TIMES = 280,
    OVER = 281,
    MOD = 282,
    LPAREN = 283,
    RPAREN = 284,
    SEMI = 285,
    ERROR = 286
  };
#endif
/* Tokens.  */
#define IF 258
#define THEN 259
#define ELSE 260
#define ENDIF 261
#define ENDWHILE 262
#define ENDDO 263
#define REPEAT 264
#define UNTIL 265
#define READ 266
#define WRITE 267
#define WHILE 268
#define DO 269
#define FOR 270
#define TO 271
#define DOWNTO 272
#define ID 273
#define NUM 274
#define ASSIGN 275
#define EQ 276
#define LT 277
#define PLUS 278
#define MINUS 279
#define TIMES 280
#define OVER 281
#define MOD 282
#define LPAREN 283
#define RPAREN 284
#define SEMI 285
#define ERROR 286

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
