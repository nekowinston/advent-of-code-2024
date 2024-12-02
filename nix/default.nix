{ mkDerivation, base, HUnit, lib, optparse-applicative }:
mkDerivation {
  pname = "advent-of-code";
  version = "0.1.0.0";
  src = ./..;
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [ base ];
  executableHaskellDepends = [ base optparse-applicative ];
  testHaskellDepends = [ base HUnit ];
  homepage = "https://code.winston.sh/winston/advent-of-code-2024";
  license = lib.licenses.bsd3;
  mainProgram = "advent-of-code";
}
