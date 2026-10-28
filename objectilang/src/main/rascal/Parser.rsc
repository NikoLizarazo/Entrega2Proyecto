module Parser


import ParseTree;
import Syntax;

start[Modulo] parseModulo(loc archivo) = parse(#start[Modulo], archivo);

start[Modulo] parseTexto(str programa) = parse(#start[Modulo], programa);
