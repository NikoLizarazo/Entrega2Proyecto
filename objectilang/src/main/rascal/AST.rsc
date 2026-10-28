module AST

// Objectilang - Sintaxis abstracta - Proyecto 2
// Sebastian Leon - 202510399
// Nicolas Lizarazo Rincon - 202511191

// Modulo y programa principal
data Modulo = modulo(list[Objeto] objetos, Principal principal);

data Principal = principal(list[Instruccion] instrucciones);

// Objetos
data Objeto
  = objeto(str nombre,
           list[Herencia] herencia,
           list[ListaGenericos] genericos,
           list[Constructor] constructor,
           list[CuerpoObjeto] cuerpo);

data Herencia = herencia(str padre);

data Constructor = constructor(list[ParametroConstructor] parametros);

data ParametroConstructor
  = parametroConstructor(Mutabilidad mutabilidad, str nombre, Tipo tipo);

data Mutabilidad
  = inmutable()
  | mutable();

data CuerpoObjeto = cuerpoObjeto(list[Instruccion] instrucciones);

data CrearObjeto
  = crearObjeto(str nombre,
           list[ArgumentosTipo] tipos,
           list[Expresion] argumentos,
           list[CuerpoObjeto] cuerpo);

data ArgumentosTipo = argumentosTipo(list[Tipo] tipos);

// Genericos
data ListaGenericos = listaGenericos(list[Generico] genericos);

data Generico = generico(list[Varianza] varianza, str nombre);

data Varianza
  = covariante()
  | contravariante();

// Tipos
data Tipo
  = tipoBasico(TipoBasico tipo)
  | tipoGenerico(str nombre, list[Tipo] tipos)
  | tipoObjeto(str nombre);

data TipoBasico
  = entero()
  | booleano()
  | texto();

// Acceso a miembros y metodos
data AccesoMiembro = accesoMiembro(list[str] nombres);

data LlamadaMetodo = llamadaMetodo(AccesoMiembro miembro, list[Expresion] argumentos);

// Declaraciones y asignacion
data TipoAnotado = tipoAnotado(Tipo tipo);

data Declaracion
  = declVal(str nombre, list[TipoAnotado] tipo, Expresion valor)
  | declVar(str nombre, list[TipoAnotado] tipo, Expresion valor);

data Asignacion = asignacion(AccesoMiembro miembro, Expresion valor);

// Metodos
data Parametro = parametro(str nombre, Tipo tipo);

data Cuerpo = cuerpo(list[Instruccion] instrucciones);

data Metodo
  = metodo(str nombre, list[Parametro] parametros, Tipo retorno, Cuerpo cuerpo)
  | metodoOverride(str nombre, list[Parametro] parametros, Tipo retorno, Cuerpo cuerpo)
  | metodoAsignado(str objeto, str nombre, list[Parametro] parametros, Tipo retorno, Cuerpo cuerpo);

// Expresiones
data Expresion
  = lit(Literal literal)
  | exprLlamada(LlamadaMetodo metodo)
  | exprAcceso(AccesoMiembro miembro)
  | exprCrear(CrearObjeto crear)
  | exprCond(Cond cond)
  | negativo(Expresion operando)
  | potencia(Expresion izquierda, Expresion derecha)
  | multiplicacion(Expresion izquierda, Expresion derecha)
  | division(Expresion izquierda, Expresion derecha)
  | residuo(Expresion izquierda, Expresion derecha)
  | suma(Expresion izquierda, Expresion derecha)
  | resta(Expresion izquierda, Expresion derecha)
  | menor(Expresion izquierda, Expresion derecha)
  | mayor(Expresion izquierda, Expresion derecha)
  | menorIgual(Expresion izquierda, Expresion derecha)
  | mayorIgual(Expresion izquierda, Expresion derecha)
  | diferente(Expresion izquierda, Expresion derecha)
  | igual(Expresion izquierda, Expresion derecha)
  | negacion(Expresion operando)
  | conjuncion(Expresion izquierda, Expresion derecha)
  | disyuncion(Expresion izquierda, Expresion derecha)
  | exprIf(IfElse ifElse);

// Condicionales
data IfElse = ifElse(Expresion condicion, Expresion entonces, Expresion sino);

data Cond = cond(list[Caso] casos);

data Caso = caso(Expresion condicion, Expresion resultado);

// Ciclo
data For = forLoop(Iterador iterador, Expresion coleccion, Cuerpo cuerpo);

data Iterador
  = iteradorSimple(str nombre)
  | iteradorMultiple(list[str] nombres);

// Instrucciones
data Instruccion
  = instDeclaracion(Declaracion declaracion)
  | instAsignacion(Asignacion asignacion)
  | instMetodo(Metodo metodo)
  | instLlamada(LlamadaMetodo llamada)
  | instIf(IfElse ifElse)
  | instFor(For ciclo);

// Literales
data Literal
  = litInt(int numero)
  | litBool(str logico)
  | litChar(str caracter)
  | litFloat(real decimal)
  | litString(str cadena);
