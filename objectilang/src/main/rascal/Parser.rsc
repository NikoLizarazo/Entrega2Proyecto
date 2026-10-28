module Parser

// Objectilang - Parser - Proyecto 2
// Sebastian Leon - 202510399
// Nicolas Lizarazo Rincon - 202511191

import ParseTree;
import Syntax;

// Parsea un archivo
start[Modulo] parseModulo(loc archivo) = parse(#start[Modulo], archivo);

// Parsea un texto
start[Modulo] parseTexto(str programa) = parse(#start[Modulo], programa);
