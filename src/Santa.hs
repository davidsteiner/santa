module Santa ( AllocatedPresent(..)
             , calculateCheckSum
             , findSolution
  ) where

import Data.Tuple

data AllocatedPresent = AllocatedPresent { kid :: Integer
                                         , sack :: Integer
                                         , present :: Integer } deriving Show

findFirst :: Integer -> Integer
findFirst 1    = 1
findFirst sack = sack ^ 2 `quot` 2

findKid :: Integer -> Integer -> Integer
findKid sack 1 = findFirst sack
findKid sack present =
  let initialSquare = if odd sack && sack > 1 then sack - 1 else sack
      finalSquare = initialSquare + present - 1
      sign = if odd $ initialSquare + finalSquare then 1 else -1
      summedSquares = sumOfSequence finalSquare + sign * sumOfSequence initialSquare
  in summedSquares - (1 - 2 * (present `rem` 2)) * findFirst sack

sumOfSequence :: Integer -> Integer
sumOfSequence to = (1 + to) * to `quot` 2

findFactors :: Integer -> [(Integer, Integer)]
findFactors n =
  -- Add the opposite pair of factors, e.g. (1, 10) => (10, 1)
  factorPairs ++ map swap (filter (uncurry (/=)) factorPairs)
  where
    -- x divisors of n up to where x^2 >= n, rest is calculated by swapping pairs
    divisors = filter ((==0) . rem n) (takeWhile ((<=n) . (^2)) [1..n])
    -- The list of factor pairs, e.g. if n == 10 then (1, 10), (2, 5)
    factorPairs = (\sack -> (sack, n `quot` sack)) <$> divisors

findSolution :: Integer -> [AllocatedPresent]
findSolution x =
  allocatePresent <$> findFactors x
  where
    allocatePresent (sack, present) = AllocatedPresent { kid = findKid sack present
                                                       , sack = sack
                                                       , present = present }

calculateCheckSum :: [AllocatedPresent] -> Integer
calculateCheckSum presents = sum (kid <$> presents) `rem` 10^9
