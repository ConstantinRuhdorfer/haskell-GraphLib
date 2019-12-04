module ParserSpec where

import Test.Hspec
import Parser
import Edge
import Vertex

spec :: Spec
spec = do

    -- Sample data
    let v0 = mkVertex 0
    let v1 = mkVertex 1
    let v2 = mkVertex 2
    let v3 = mkVertex 3
    let v4 = mkVertex 4

    let e1 = mkEdge v1 v2
    let e2 = mkEdge v3 v4

    describe "strToInt" $ do
        it "should map a list of string integers to integers" $ do
            (strToInt ["1", "2", "3"]) `shouldBe` [1, 2, 3]

    describe "parseInputVertecies" $ do
        it "should parse a integers to vertecies" $ do
            (parseInputVertecies 4) `shouldBe` [v0, v1, v2, v3]

    describe "parseInputEdges" $ do
        it "should parse a list of integers to edges" $ do
            (parseInputEdges [1, 2, 3, 4]) `shouldBe` [e2, e1]