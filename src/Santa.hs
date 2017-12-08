module Santa (calculateKidID, findSolution) where

import Data.Tuple


-- Find the first kid's ID in any given sack
findFirst :: Integer -> Integer
findFirst 1    = 1
findFirst sack = sack ^ 2 `quot` 2

-- Calculate the kid's ID for given sack and present pair
calculateKidID :: (Integer, Integer) -> Integer
calculateKidID (sack, present) =
  let
      initialSquare = if odd sack && sack > 1 then sack - 1 else sack
      finalSquare = initialSquare + present - 1
      sign = if odd $ initialSquare + finalSquare then 1 else -1
      summedSquares = sumTo finalSquare + sign * sumTo initialSquare
  -- From the sum of squares we need to either subtract or add the first kid
  -- depending on whether the present is odd or even
  in summedSquares - (1 - 2 * (present `rem` 2)) * findFirst sack
  where
    -- Sum numbers from 1 to n, e.g. for n = 3, then return 1 + 2 + 3 = 6
    sumTo n = (1 + n) * n `quot` 2

calculateFactors :: Integer -> [(Integer, Integer)]
calculateFactors n =
  -- Add the opposite pair of factors, e.g. (1, 10) => (10, 1)
  factorPairs ++ map swap (filter (uncurry (/=)) factorPairs)
  where
    -- x divisors of n up to where x^2 >= n, rest is calculated by swapping pairs
    divisors = filter ((==0) . rem n) (takeWhile ((<=n) . (^2)) [1..n])
    -- The list of factor pairs, e.g. if n == 10 then (1, 10), (2, 5)
    factorPairs = (\sack -> (sack, n `quot` sack)) <$> divisors

findSolution :: Integer -> Integer
findSolution n =
  sum (calculateKidID <$> calculateFactors n) `rem` 10^8
