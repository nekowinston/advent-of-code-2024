{ mkDerivation, base, HUnit, lib, optparse-applicative
, raw-strings-qq, regex-tdfa
}:
mkDerivation {
  pname = "advent-of-code";
  version = "0.1.0.0";
  src = ./..;
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [ base raw-strings-qq regex-tdfa ];
  executableHaskellDepends = [
    base optparse-applicative raw-strings-qq regex-tdfa
  ];
  testHaskellDepends = [ base HUnit raw-strings-qq regex-tdfa ];
  homepage = "https://code.winston.sh/winston/advent-of-code-2024";
  license = lib.licenses.bsd3;
  mainProgram = "advent-of-code";
}
