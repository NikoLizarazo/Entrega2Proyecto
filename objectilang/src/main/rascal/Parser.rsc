module Parser


import ParseTree;
import Syntax;

// Parsea un archivo
start[Modulo] parseModulo(loc archivo) = parse(#start[Modulo], archivo);

// Parsea un texto
start[Modulo] parseTexto(str programa) = parse(#start[Modulo], programa);
