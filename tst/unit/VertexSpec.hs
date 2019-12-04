module VertexSpec where

import Test.Hspec
import Control.Exception (evaluate)

import Vertex

spec :: Spec
spec = do

    let v = mkVertex 1

    describe "mkVertex" $ do
        it "should make a vertex" $ do
            v `shouldBe` v
    
        it "should return on error on id -1" $ do
            evaluate (mkVertex (-1)) `shouldThrow`  (errorCall "Should not be negative")
    
    describe "showVertex" $ do
        it "converts a verterx to a string of v_*" $ do
            (show v) `shouldBe` "v_1"
    
    describe "getVertexId" $ do
        it "should return the vertex id" $ do
            getVertexId v `shouldBe` 1