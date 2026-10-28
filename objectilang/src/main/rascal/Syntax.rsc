module Syntax


layout Layout = WhitespaceAndComment* !>> [\ \t\n\r];

lexical WhitespaceAndComment = [\ \t\n\r];

// Modulo y programa principal
start syntax Modulo
  = modulo: Objeto* objetos Principal principal
  ;

syntax Principal
  = principal: "method" "main" "{" Instruccion* instrucciones "}"
  ;

// Objetos
syntax Objeto
  = objeto: "object" Identifier nombre
            Herencia? herencia
            ListaGenericos? genericos
            Constructor? constructor
            CuerpoObjeto? cuerpo
  ;

syntax Herencia
  = herencia: "extends" Identifier padre
  ;

syntax Constructor
  = constructor: "(" {ParametroConstructor ","}* parametros ")"
  ;

syntax ParametroConstructor
  = parametroConstructor: Mutabilidad mutabilidad Identifier nombre ":" Tipo tipo
  ;

syntax Mutabilidad
  = inmutable: "val"
  | mutable: "var"
  ;

syntax CuerpoObjeto
  = cuerpoObjeto: "{" Instruccion* instrucciones "}"
  ;

syntax CrearObjeto
  = crearObjeto: "new" Identifier nombre ArgumentosTipo? tipos
                 "(" {Expresion ","}* argumentos ")" CuerpoObjeto? cuerpo
  ;

syntax ArgumentosTipo
  = argumentosTipo: "[" {Tipo ","}+ tipos "]"
  ;

// Genericos
syntax ListaGenericos
  = listaGenericos: "[" {Generico ","}+ genericos "]"
  ;

syntax Generico
  = generico: Varianza? varianza Identifier nombre
  ;

syntax Varianza
  = covariante: "+"
  | contravariante: "-"
  ;

// Tipos
syntax Tipo
  = tipoBasico: TipoBasico tipo
  | tipoGenerico: Identifier nombre "[" {Tipo ","}+ tipos "]"
  | tipoObjeto: Identifier nombre
  ;

syntax TipoBasico
  = entero: "Int"
  | booleano: "Bool"
  | texto: "String"
  ;


syntax AccesoMiembro
  = accesoMiembro: {Identifier "."}+ nombres
  ;

syntax LlamadaMetodo
  = llamadaMetodo: AccesoMiembro miembro "(" {Expresion ","}* argumentos ")"
  ;

// Declaraciones y asignacion
syntax TipoAnotado
  = tipoAnotado: ":" Tipo tipo
  ;

syntax Declaracion
  = declVal: "val" Identifier nombre TipoAnotado? tipo "=" Expresion valor
  | declVar: "var" Identifier nombre TipoAnotado? tipo "=" Expresion valor
  ;

syntax Asignacion
  = asignacion: AccesoMiembro miembro "=" Expresion valor
  ;

// Metodos
syntax Parametro
  = parametro: Identifier nombre ":" Tipo tipo
  ;

syntax Cuerpo
  = cuerpo: "{" Instruccion* instrucciones "}"
  ;

syntax Metodo
  = metodo: "method" Identifier nombre "(" {Parametro ","}* parametros ")" ":" Tipo retorno Cuerpo cuerpo
  | metodoOverride: "override" Identifier nombre "(" {Parametro ","}* parametros ")" ":" Tipo retorno Cuerpo cuerpo
  | metodoAsignado: Identifier objeto "." Identifier nombre "=" "method" "(" {Parametro ","}* parametros ")" ":" Tipo retorno Cuerpo cuerpo
  ;

// Expresiones de mayor a menor precedencia
syntax Expresion
  = lit: Literal literal
  | exprLlamada: LlamadaMetodo metodo
  | exprAcceso: AccesoMiembro miembro
  | exprCrear: CrearObjeto crear
  | exprCond: Cond cond
  | bracket "(" Expresion expresion ")"
  > negativo: "-" Expresion operando
  > right potencia: Expresion izquierda "**" Expresion derecha
  > left ( multiplicacion: Expresion izquierda "*" Expresion derecha
         | division: Expresion izquierda "/" Expresion derecha
         | residuo: Expresion izquierda "%" Expresion derecha
         )
  > left ( suma: Expresion izquierda "+" Expresion derecha
         | resta: Expresion izquierda "-" Expresion derecha
         )
  > non-assoc ( menor: Expresion izquierda "\<" Expresion derecha
              | mayor: Expresion izquierda "\>" Expresion derecha
              | menorIgual: Expresion izquierda "\<=" Expresion derecha
              | mayorIgual: Expresion izquierda "\>=" Expresion derecha
              | diferente: Expresion izquierda "\<\>" Expresion derecha
              | igual: Expresion izquierda "=" Expresion derecha
              )
  > negacion: "neg" Expresion operando
  > left conjuncion: Expresion izquierda "and" Expresion derecha
  > left disyuncion: Expresion izquierda "or" Expresion derecha
  > exprIf: IfElse ifElse
  ;

// Condicionales
syntax IfElse
  = ifElse: "if" Expresion condicion "then" Expresion entonces "else" Expresion sino
  ;

syntax Cond
  = cond: "cond" "{" {Caso ","}+ casos "}"
  ;

syntax Caso
  = caso: Expresion condicion "-\>" Expresion resultado
  ;

// Ciclo
syntax For
  = forLoop: "for" "(" Iterador iterador "in" Expresion coleccion ")" Cuerpo cuerpo
  ;

syntax Iterador
  = iteradorSimple: Identifier nombre
  | iteradorMultiple: "(" {Identifier ","}+ nombres ")"
  ;

// Instrucciones
syntax Instruccion
  = instDeclaracion: Declaracion declaracion
  | instAsignacion: Asignacion asignacion
  | instMetodo: Metodo metodo
  | instLlamada: LlamadaMetodo llamada
  | instIf: IfElse ifElse
  | instFor: For ciclo
  ;

// Literales
syntax Literal
  = litInt: IntLit numero
  | litBool: BoolLit logico
  | litChar: CharLit caracter
  | litFloat: FloatLit decimal
  | litString: StringLit cadena
  ;

lexical IntLit
  = @category="number" [0-9]+ !>> [0-9]
  ;

lexical FloatLit
  = @category="number" ([0-9]+ "." [0-9]+) !>> [0-9]
  ;

lexical BoolLit
  = @category="Constant" "True"
  | @category="Constant" "False"
  ;

lexical CharLit
  = @category="string" ("\'" [a-zA-Z] "\'")
  ;

// Cadenas con interpolacion
lexical StringLit
  = @category="string" ("\"" StringPart* "\"")
  ;

lexical StringPart
  = StringChar
  | Interpolacion
  ;

lexical StringChar
  = ![\"$]
  ;

lexical Interpolacion
  = "$" "{" Expresion "}"
  ;

// Palabras reservadas
lexical Identifier
  = ([a-z][a-zA-Z0-9\-]* !>> [a-zA-Z0-9\-]) \ Reserved
  ;

keyword Reserved
  = "object" | "extends" | "method" | "main" | "val" | "var" | "new"
  | "override" | "if" | "then" | "else" | "cond" | "for" | "in"
  | "and" | "or" | "neg" | "True" | "False" | "Int" | "Bool" | "String"
  ;
