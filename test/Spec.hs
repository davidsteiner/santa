import Santa
import Test.Hspec

main :: IO ()
main = hspec $ do
  describe "Santa" $ do
    describe "calculateKidID" $ do
      it "returns 1 for first present in first sack" $ do
        calculateKidID (1, 1) `shouldBe` (1 :: Integer)

      it "returns 2 for first present in second sack" $ do
        calculateKidID (2, 1) `shouldBe` (2 :: Integer)

      it "returns 3 for second present in first sack" $ do
        calculateKidID (1, 2) `shouldBe` (3 :: Integer)

      it "returns 4 for first present in third sack" $ do
        calculateKidID (3, 1) `shouldBe` (4 :: Integer)

    describe "findSolution" $ do
      it "returns 14257 for input 100" $ do
        findSolution 100 `shouldBe` (14257 :: Integer)

      it "returns 77301763 for input 6300000000" $ do
        findSolution 6300000000 `shouldBe` (77301763 :: Integer)
