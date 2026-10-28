module Implode



import IO;
import ParseTree;
import Syntax;
import AST;
import Parser;

AST::Modulo implodeArbol(Tree arbol) = implode(#AST::Modulo, arbol);

AST::Modulo implodeArchivo(loc archivo) {
  cst = parseModulo(archivo);
  return implodeArbol(cst.top);
}

AST::Modulo implodeTexto(str programa) {
  cst = parseTexto(programa);
  return implodeArbol(cst.top);
}

str astComoTexto(Tree arbol) {
  ast = implodeArbol(arbol);
  return iprintToString(ast);
}

void probar() {
  ast = implodeArchivo(|project://objectilang/instance/ejemplo.obj|);
  iprintln(ast);
}
