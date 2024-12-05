[private]
default: build test

build *args:
  cabal build {{args}}

run *args:
  cabal run -- advent-of-code {{args}}

bench:
  cabal bench -O2 --benchmark-options "--output benchmark-report.html"

test:
  cabal test
