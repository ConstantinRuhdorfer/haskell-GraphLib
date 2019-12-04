module EdgeSpec where

import Test.Hspec
import Edge
import Vertex

spec :: Spec
spec = do

    -- Sample data
    let v1 = mkVertex 1
    let v2 = mkVertex 2
    let v3 = mkVertex 3

    let e1 = mkEdge v1 v2

    describe "mkEdge" $ do
        it "should make an edge" $ do
            (mkEdge v1 v2) `shouldBe` e1
    
    describe "show edge" $ do
        it "should show an edge" $ do
            (show e1) `shouldBe` "e(v_1 - v_2)"

    describe "getOtherVertex" $ do
        it "should return the other vertex" $ do
            (getOtherVertex e1 v1) `shouldBe` v2

    describe "getVertexA" $ do
        it "should return the first vertex" $ do
            (getVertexA e1) `shouldBe` v1

    describe "getVertexB" $ do
        it "should return the second vertex" $ do
            (getVertexB e1) `shouldBe` v2

    describe "occursInEdge" $ do
        it "should return true for v_1 in e(v_1 - v_2)" $ do
            (occursInEdge e1 v1) `shouldBe` True
        
        it "should return false for v_3 in e(v_1 - v_2)" $ do
            (occursInEdge e1 v3) `shouldBe` False