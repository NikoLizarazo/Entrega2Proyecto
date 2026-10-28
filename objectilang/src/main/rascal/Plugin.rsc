module Plugin

// Objectilang - Plugin - Proyecto 2
// Sebastian Leon - 202510399
// Nicolas Lizarazo Rincon - 202511191

import IO;
import ParseTree;
import util::Reflective;
import util::IDEServices;
import util::LanguageServer;
import Relation;

import Syntax;
import Implode;

PathConfig pcfg = getProjectPathConfig(|project://objectilang|, mode=interpreter_external());
Language objLang = language(pcfg, "Objectilang", {"obj"}, "Plugin", "contribs");

data Command = verAst(Modulo modulo);

set[LanguageService] contribs() = {
    parsing(parser(#start[Modulo]), usesSpecialCaseHighlighting = false),
    codeLens(lrel[loc, Command] (start[Modulo] p) {
        return [<p.src, verAst(p.top, title="Mostrar AST")>];
    }),
    execution(exec)
};

value exec(verAst(Modulo m)) {
    rVal = astComoTexto(m);
    outputFile = |project://objectilang/instance/output/ast.txt|;
    writeFile(outputFile, rVal);
    edit(outputFile);
    return ("result": true);
}

void main() {
    registerLanguage(objLang);
}
