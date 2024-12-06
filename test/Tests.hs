module Tests where

type Part = Int
type Expected = Int
data InputOutput
  = Input Expected -- user input
  | Fixture Expected -- puzzle fixtures
  | InlineFixture Expected String -- puzzle fixtures provided as string
  deriving (Show)

solverTests :: [([InputOutput], [InputOutput])]
solverTests =
  [ ([Fixture 11, Input 2192892], [Fixture 31, Input 22962826])
  , ([Fixture 2, Input 332], [Fixture 4, Input 398])
  ,
    ( [InlineFixture 161 "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))", Input 175015740]
    , [InlineFixture 48 "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))", Input 112272912]
    )
  , ([Fixture 18, Input 2483], [Fixture 9, Input 1925])
  , ([Fixture 143, Input 4774], [Fixture 123, Input 6004])
  ]
