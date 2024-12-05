{ mkDerivation, base, HUnit, lib, massiv, optparse-applicative
, raw-strings-qq, regex-tdfa, text, universe-base
}:
mkDerivation {
  pname = "advent-of-code";
  version = "0.1.0.0";
  src = ./..;
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [
    base massiv raw-strings-qq regex-tdfa text universe-base
  ];
  executableHaskellDepends = [
    base massiv optparse-applicative raw-strings-qq regex-tdfa text
    universe-base
  ];
  testHaskellDepends = [
    base HUnit massiv raw-strings-qq regex-tdfa text universe-base
  ];
  homepage = "https://code.winston.sh/winston/advent-of-code-2024";
  license = lib.licenses.bsd3;
  mainProgram = "advent-of-code";
}
