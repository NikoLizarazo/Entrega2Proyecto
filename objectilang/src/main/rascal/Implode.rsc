module Implode

// Objectilang - Implode - Proyecto 2
// Sebastian Leon - 202510399
// Nicolas Lizarazo Rincon - 202511191

import IO;
import ParseTree;
import Syntax;
import AST;
import Parser;

// Se usa AST::Modulo porque Syntax tambien tiene un Modulo
AST::Modulo implodeArbol(Tree arbol) = implode(#AST::Modulo, arbol);

AST::Modulo implodeArchivo(loc archivo) {
  cst = parseModulo(archivo);
  return implodeArbol(cst.top);
}

AST::Modulo implodeTexto(str programa) {
  cst = parseTexto(programa);
  return implodeArbol(cst.top);
}

// Lo usa el boton "Mostrar AST" del plugin
str astComoTexto(Tree arbol) {
  ast = implodeArbol(arbol);
  return iprintToString(ast);
}

// Para probar desde la terminal: import Implode; probar();
void probar() {
  ast = implodeArchivo(|project://objectilang/instance/ejemplo.obj|);
  iprintln(ast);
}
