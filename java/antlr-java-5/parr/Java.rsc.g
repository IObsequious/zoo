grammar Java;


compilationUnit
    :   annotations
        (   packageDeclaration importDeclaration* typeDeclaration*
        |   classOrInterfaceDeclaration typeDeclaration*
        )
    |   packageDeclaration? importDeclaration* typeDeclaration*
    ;

packageDeclaration
    :   'package' qualifiedName ';'
    ;
    
importDeclaration
    :   'import' 'static'? qualifiedName ('.' '*')? ';'
    ;
    
typeDeclaration
    :   classOrInterfaceDeclaration
    |   ';'
    ;
    
classOrInterfaceDeclaration
    :   classOrInterfaceModifiers (classDeclaration | interfaceDeclaration)
    ;
    
classOrInterfaceModifiers
    :   classOrInterfaceModifier*
    ;

classOrInterfaceModifier
    :   annotation   
    |   'public'     
    |   'protected'  
    |   'private'    
    |   'abstract'   
    |   'static'     
    |   'final'      
    |   'strictfp'   
    ;

modifiers
    :   modifier*
    ;

classDeclaration
    :   normalClassDeclaration
    |   enumDeclaration
    ;
    
normalClassDeclaration
    :   'class' Identifier typeParameters?
        ('extends' type)?
        ('implements' typeList)?
        classBody
    ;
    
typeParameters
    :   '<' typeParameter (',' typeParameter)* '>'
    ;

typeParameter
    :   Identifier ('extends' typeBound)?
    ;
        
typeBound
    :   type ('&' type)*
    ;

enumDeclaration
    :   ENUM Identifier ('implements' typeList)? enumBody
    ;

enumBody
    :   '{' enumConstants? ','? enumBodyDeclarations? '}'
    ;

enumConstants
    :   enumConstant (',' enumConstant)*
    ;
    
enumConstant
    :   annotations? Identifier arguments? classBody?
    ;
    
enumBodyDeclarations
    :   ';' (classBodyDeclaration)*
    ;
    
interfaceDeclaration
    :   normalInterfaceDeclaration
    |   annotationTypeDeclaration
    ;
    
normalInterfaceDeclaration
    :   'interface' Identifier typeParameters? ('extends' typeList)? interfaceBody
    ;
    
typeList
    :   type (',' type)*
    ;
    
classBody
    :   '{' classBodyDeclaration* '}'
    ;
    
interfaceBody
    :   '{' interfaceBodyDeclaration* '}'
    ;

classBodyDeclaration
    :   ';'
    |   'static'? block
    |   modifiers memberDecl
    ;
    
memberDecl
    :   genericMethodOrConstructorDecl
    |   memberDeclaration
    |   'void' Identifier voidMethodDeclaratorRest
    |   Identifier constructorDeclaratorRest
    |   interfaceDeclaration
    |   classDeclaration
    ;
    
memberDeclaration
    :   type (methodDeclaration | fieldDeclaration)
    ;

genericMethodOrConstructorDecl
    :   typeParameters genericMethodOrConstructorRest
    ;
    
genericMethodOrConstructorRest
    :   (type | 'void') Identifier methodDeclaratorRest
    |   Identifier constructorDeclaratorRest
    ;

methodDeclaration
    :   Identifier methodDeclaratorRest
    ;

fieldDeclaration
    :   variableDeclarators ';'
    ;
        
interfaceBodyDeclaration
    :   modifiers interfaceMemberDecl
    |   ';'
    ;

interfaceMemberDecl
    :   interfaceMethodOrFieldDecl
    |   interfaceGenericMethodDecl
    |   'void' Identifier voidInterfaceMethodDeclaratorRest
    |   interfaceDeclaration
    |   classDeclaration
    ;
    
interfaceMethodOrFieldDecl
    :   type Identifier interfaceMethodOrFieldRest
    ;
    
interfaceMethodOrFieldRest
    :   constantDeclaratorsRest ';'
    |   interfaceMethodDeclaratorRest
    ;
    
methodDeclaratorRest
    :   formalParameters ('[' ']')*
        ('throws' qualifiedNameList)?
        (   methodBody
        |   ';'
        )
    ;
    
voidMethodDeclaratorRest
    :   formalParameters ('throws' qualifiedNameList)?
        (   methodBody
        |   ';'
        )
    ;
    
interfaceMethodDeclaratorRest
    :   formalParameters ('[' ']')* ('throws' qualifiedNameList)? ';'
    ;
    
interfaceGenericMethodDecl
    :   typeParameters (type | 'void') Identifier
        interfaceMethodDeclaratorRest
    ;
    
voidInterfaceMethodDeclaratorRest
    :   formalParameters ('throws' qualifiedNameList)? ';'
    ;
    
constructorDeclaratorRest
    :   formalParameters ('throws' qualifiedNameList)? constructorBody
    ;

constantDeclarator
    :   Identifier constantDeclaratorRest
    ;
    
variableDeclarators
    :   variableDeclarator (',' variableDeclarator)*
    ;

variableDeclarator
    :   variableDeclaratorId ('=' variableInitializer)?
    ;
    
constantDeclaratorsRest
    :   constantDeclaratorRest (',' constantDeclarator)*
    ;

constantDeclaratorRest
    :   ('[' ']')* '=' variableInitializer
    ;
    
variableDeclaratorId
    :   Identifier ('[' ']')*
    ;

variableInitializer
    :   arrayInitializer
    |   expression
    ;
        
arrayInitializer
    :   '{' (variableInitializer (',' variableInitializer)* (',')? )? '}'
    ;

modifier
    :   annotation
    |   'public'
    |   'protected'
    |   'private'
    |   'static'
    |   'abstract'
    |   'final'
    |   'native'
    |   'synchronized'
    |   'transient'
    |   'volatile'
    |   'strictfp'
    ;

packageOrTypeName
    :   qualifiedName
    ;

enumConstantName
    :   Identifier
    ;

typeName
    :   qualifiedName
    ;

type
	:	classOrInterfaceType ('[' ']')*
	|	primitiveType ('[' ']')*
	;

classOrInterfaceType
	:	Identifier typeArguments? ('.' Identifier typeArguments? )*
	;

primitiveType
    :   'boolean'
    |   'char'
    |   'byte'
    |   'short'
    |   'int'
    |   'long'
    |   'float'
    |   'double'
    ;

variableModifier
    :   'final'
    |   annotation
    ;

typeArguments
    :   '<' typeArgument (',' typeArgument)* '>'
    ;
    
typeArgument
    :   type
    |   '?' (('extends' | 'super') type)?
    ;
    
qualifiedNameList
    :   qualifiedName (',' qualifiedName)*
    ;

formalParameters
    :   '(' formalParameterDecls? ')'
    ;
    
formalParameterDecls
    :   variableModifiers type formalParameterDeclsRest
    ;
    
formalParameterDeclsRest
    :   variableDeclaratorId (',' formalParameterDecls)?
    |   '...' variableDeclaratorId
    ;
    
methodBody
    :   block
    ;

constructorBody
    :   '{' explicitConstructorInvocation? blockStatement* '}'
    ;

explicitConstructorInvocation
    :   nonWildcardTypeArguments? ('this' | 'super') arguments ';'
    |   primary '.' nonWildcardTypeArguments? 'super' arguments ';'
    ;


qualifiedName
    :   Identifier ('.' Identifier)*
    ;
    
literal 
    :   integerLiteral
    |   FloatingPointLiteral
    |   CharacterLiteral
    |   StringLiteral
    |   booleanLiteral
    |   'null'
    ;

integerLiteral
    :   HexLiteral
    |   OctalLiteral
    |   DecimalLiteral
    ;

booleanLiteral
    :   'true'
    |   'false'
    ;



annotations
    :   annotation+
    ;

annotation
    :   '@' annotationName ( '(' ( elementValuePairs | elementValue )? ')' )?
    ;
    
annotationName
    : Identifier ('.' Identifier)*
    ;

elementValuePairs
    :   elementValuePair (',' elementValuePair)*
    ;

elementValuePair
    :   Identifier '=' elementValue
    ;
    
elementValue
    :   conditionalExpression
    |   annotation
    |   elementValueArrayInitializer
    ;
    
elementValueArrayInitializer
    :   '{' (elementValue (',' elementValue)*)? (',')? '}'
    ;
    
annotationTypeDeclaration
    :   '@' 'interface' Identifier annotationTypeBody
    ;
    
annotationTypeBody
    :   '{' (annotationTypeElementDeclaration)* '}'
    ;
    
annotationTypeElementDeclaration
    :   modifiers annotationTypeElementRest
    ;
    
annotationTypeElementRest
    :   type annotationMethodOrConstantRest ';'
    |   normalClassDeclaration ';'?
    |   normalInterfaceDeclaration ';'?
    |   enumDeclaration ';'?
    |   annotationTypeDeclaration ';'?
    ;
    
annotationMethodOrConstantRest
    :   annotationMethodRest
    |   annotationConstantRest
    ;
    
annotationMethodRest
    :   Identifier '(' ')' defaultValue?
    ;
    
annotationConstantRest
    :   variableDeclarators
    ;
    
defaultValue
    :   'default' elementValue
    ;



block
    :   '{' blockStatement* '}'
    ;
    
blockStatement
    :   localVariableDeclarationStatement
    |   classOrInterfaceDeclaration
    |   statement
    ;
    
localVariableDeclarationStatement
    :    localVariableDeclaration ';'
    ;

localVariableDeclaration
    :   variableModifiers type variableDeclarators
    ;
    
variableModifiers
    :   variableModifier*
    ;

statement
    : block
    |   ASSERT expression (':' expression)? ';'
    |   'if' parExpression statement ('else' statement)?
    |   'for' '(' forControl ')' statement
    |   'while' parExpression statement
    |   'do' statement 'while' parExpression ';'
    |   'try' block
        ( catches 'finally' block
        | catches
        |   'finally' block
        )
    |   'switch' parExpression '{' switchBlockStatementGroups '}'
    |   'synchronized' parExpression block
    |   'return' expression? ';'
    |   'throw' expression ';'
    |   'break' Identifier? ';'
    |   'continue' Identifier? ';'
    |   ';' 
    |   statementExpression ';'
    |   Identifier ':' statement
    ;
    
catches
    :   catchClause (catchClause)*
    ;
    
catchClause
    :   'catch' '(' formalParameter ')' block
    ;

formalParameter
    :   variableModifiers type variableDeclaratorId
    ;
        
switchBlockStatementGroups
    :   (switchBlockStatementGroup)*
    ;
    

switchBlockStatementGroup
    :   switchLabel+ blockStatement*
    ;
    
switchLabel
    :   'case' constantExpression ':'
    |   'case' enumConstantName ':'
    |   'default' ':'
    ;
    
forControl
    :   enhancedForControl
    |   forInit? ';' expression? ';' forUpdate?
    ;

forInit
    :   localVariableDeclaration
    |   expressionList
    ;
    
enhancedForControl
    :   variableModifiers type Identifier ':' expression
    ;

forUpdate
    :   expressionList
    ;



parExpression
    :   '(' expression ')'
    ;
    
expressionList
    :   expression (',' expression)*
    ;

statementExpression
    :   expression
    ;
    
constantExpression
    :   expression
    ;
    
expression
    :   conditionalExpression (assignmentOperator expression)?
    ;
    
assignmentOperator
    :   '='
    |   '+='
    |   '-='
    |   '*='
    |   '/='
    |   '&='
    |   '|='
    |   '^='
    |   '%='
    |   t1='<' t2='<' t3='='|   t1='>' t2='>' t3='>' t4='='?|   t1='>' t2='>' t3='=';

conditionalExpression
    :   conditionalOrExpression ( '?' expression ':' expression )?
    ;

conditionalOrExpression
    :   conditionalAndExpression ( '||' conditionalAndExpression )*
    ;

conditionalAndExpression
    :   inclusiveOrExpression ( '&&' inclusiveOrExpression )*
    ;

inclusiveOrExpression
    :   exclusiveOrExpression ( '|' exclusiveOrExpression )*
    ;

exclusiveOrExpression
    :   andExpression ( '^' andExpression )*
    ;

andExpression
    :   equalityExpression ( '&' equalityExpression )*
    ;

equalityExpression
    :   instanceOfExpression ( ('==' | '!=') instanceOfExpression )*
    ;

instanceOfExpression
    :   relationalExpression ('instanceof' type)?
    ;

relationalExpression
    :   shiftExpression ( relationalOp shiftExpression )*
    ;
    
relationalOp
    :   t1='<' t2='='?|   t1='>' t2='='?|   '<' 
    |   '>' 
    ;

shiftExpression
    :   additiveExpression ( shiftOp additiveExpression )*
    ;

shiftOp
    :   t1='<' t2='<'?|   t1='>' t2='>' t3='>'|   t1='>' t2='>'?;


additiveExpression
    :   multiplicativeExpression ( ('+' | '-') multiplicativeExpression )*
    ;

multiplicativeExpression
    :   unaryExpression ( ( '*' | '/' | '%' ) unaryExpression )*
    ;
    
unaryExpression
    :   '+' unaryExpression
    |   '-' unaryExpression
    |   '++' unaryExpression
    |   '--' unaryExpression
    |   unaryExpressionNotPlusMinus
    ;

unaryExpressionNotPlusMinus
    :   '~' unaryExpression
    |   '!' unaryExpression
    |   castExpression
    |   primary selector* ('++'|'--')?
    ;

castExpression
    :  '(' primitiveType ')' unaryExpression
    |  '(' (type | expression) ')' unaryExpressionNotPlusMinus
    ;

primary
    :   parExpression
    |   'this' ('.' Identifier)* identifierSuffix?
    |   'super' superSuffix
    |   literal
    |   'new' creator
    |   Identifier ('.' Identifier)* identifierSuffix?
    |   primitiveType ('[' ']')* '.' 'class'
    |   'void' '.' 'class'
    ;

identifierSuffix
    :   ('[' ']')+ '.' 'class'
    |   ('[' expression ']')+ 
    |   arguments
    |   '.' 'class'
    |   '.' explicitGenericInvocation
    |   '.' 'this'
    |   '.' 'super' arguments
    |   '.' 'new' innerCreator
    ;

creator
    :   nonWildcardTypeArguments createdName classCreatorRest
    |   createdName (arrayCreatorRest | classCreatorRest)
    ;

createdName
    :   classOrInterfaceType
    |   primitiveType
    ;
    
innerCreator
    :   nonWildcardTypeArguments? Identifier classCreatorRest
    ;

arrayCreatorRest
    :   '['
        (   ']' ('[' ']')* arrayInitializer
        |   expression ']' ('[' expression ']')* ('[' ']')*
        )
    ;

classCreatorRest
    :   arguments classBody?
    ;
    
explicitGenericInvocation
    :   nonWildcardTypeArguments Identifier arguments
    ;
    
nonWildcardTypeArguments
    :   '<' typeList '>'
    ;
    
selector
    :   '.' Identifier arguments?
    |   '.' 'this'
    |   '.' 'super' superSuffix
    |   '.' 'new' innerCreator
    |   '[' expression ']'
    ;
    
superSuffix
    :   arguments
    |   '.' Identifier arguments?
    ;

arguments
    :   '(' expressionList? ')'
    ;



HexLiteral : '0' ('x'|'X') HexDigit+ IntegerTypeSuffix? ;

DecimalLiteral : ('0' | ('1'|'2'|'3'|'4'|'5'|'6'|'7'|'8'|'9') ('0'|'1'|'2'|'3'|'4'|'5'|'6'|'7'|'8'|'9')*) IntegerTypeSuffix? ;

OctalLiteral : '0' (('0'|'1'|'2'|'3'|'4'|'5'|'6'|'7'))+ IntegerTypeSuffix? ;

HexDigit: (('0'|'1'|'2'|'3'|'4'|'5'|'6'|'7'|'8'|'9')|('a'|'b'|'c'|'d'|'e'|'f')|('A'|'B'|'C'|'D'|'E'|'F')) ;

IntegerTypeSuffix: ('l'|'L') ;

FloatingPointLiteral
    :   (('0'|'1'|'2'|'3'|'4'|'5'|'6'|'7'|'8'|'9'))+ '.' (('0'|'1'|'2'|'3'|'4'|'5'|'6'|'7'|'8'|'9'))* Exponent? FloatTypeSuffix?
    |   '.' (('0'|'1'|'2'|'3'|'4'|'5'|'6'|'7'|'8'|'9'))+ Exponent? FloatTypeSuffix?
    |   (('0'|'1'|'2'|'3'|'4'|'5'|'6'|'7'|'8'|'9'))+ Exponent FloatTypeSuffix?
    |   (('0'|'1'|'2'|'3'|'4'|'5'|'6'|'7'|'8'|'9'))+ FloatTypeSuffix
    ;

Exponent: ('e'|'E') ('+'|'-')? (('0'|'1'|'2'|'3'|'4'|'5'|'6'|'7'|'8'|'9'))+ ;

FloatTypeSuffix: ('f'|'F'|'d'|'D') ;

CharacterLiteral
    :   '\'' ( EscapeSequence | BGF_STRING ) '\''
    ;

StringLiteral
    :  '"' ( EscapeSequence | BGF_STRING )* '"'
    ;

EscapeSequence: '\\' ('b'|'t'|'n'|'f'|'r'|'\"'|'\''|'\\')
    |   UnicodeEscape
    |   OctalEscape
    ;

OctalEscape: '\\' ('0'|'1'|'2'|'3') (('0'|'1'|'2'|'3'|'4'|'5'|'6'|'7')) (('0'|'1'|'2'|'3'|'4'|'5'|'6'|'7'))
    |   '\\' (('0'|'1'|'2'|'3'|'4'|'5'|'6'|'7')) (('0'|'1'|'2'|'3'|'4'|'5'|'6'|'7'))
    |   '\\' (('0'|'1'|'2'|'3'|'4'|'5'|'6'|'7'))
    ;

UnicodeEscape: '\\' 'u' HexDigit HexDigit HexDigit HexDigit
    ;

ENUM:   'enum'
    ;
    
ASSERT
    :   'assert'
    ;
    
Identifier 
    :   Letter (Letter|JavaIDDigit)*
    ;


Letter: 'a'|'b'|'c'|'d'|'e'|'f'|'g'|'h'|'i'|'j'|'k'|'l'|'m'|'n'|'o'|'p'|'q'|'r'|'s'|'t'|'u'|'v'|'w'|'x'|'y'|'z'|'A'|'B'|'C'|'D'|'E'|'F'|'G'|'H'|'I'|'J'|'K'|'L'|'M'|'N'|'O'|'P'|'Q'|'R'|'S'|'T'|'U'|'V'|'W'|'X'|'Y'|'Z'
    ;

JavaIDDigit: '0'|'1'|'2'|'3'|'4'|'5'|'6'|'7'|'8'|'9'|'a'|'b'|'c'|'d'|'e'|'f'|'g'|'h'|'i'|'j'|'k'|'l'|'m'|'n'|'o'|'p'|'q'|'r'|'s'|'t'|'u'|'v'|'w'|'x'|'y'|'z'|'A'|'B'|'C'|'D'|'E'|'F'|'G'|'H'|'I'|'J'|'K'|'L'|'M'|'N'|'O'|'P'|'Q'|'R'|'S'|'T'|'U'|'V'|'W'|'X'|'Y'|'Z'
   ;

WS  :  (' '|'\r'|'\t'|'\u000C'|'\n');

COMMENT
    :   '/*' ( ANYTHING )* '*/';