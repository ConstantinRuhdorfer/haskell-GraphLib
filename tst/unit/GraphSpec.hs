module GraphSpec where

import Test.Hspec
import Control.Exception (evaluate)

import Graph
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
    let e2 = mkEdge v2 v3

    let g = mkGraph [v0, v1, v2, v3, v4] [e1, e2]

    describe "mkGraph" $ do
        it "should make a graph" $ do
            (mkGraph [v0, v1, v2, v3, v4] [e1, e2]) `shouldBe` g

    describe "getNeighbours" $ do
        it "should get the neighbours for a vertex with neighbours" $ do
            (getNeighbours g v2) `shouldBe` [v1, v3]

        it "should get no neighbours for a vertex with no neighbours" $ do
            (getNeighbours g v4) `shouldBe` []

    describe "path" $ do
        it "should return a path when one exists" $ do
            path g v1 v3 `shouldBe` [v1, v2, v3]

        it "should throw an error when no path exists" $ do
            evaluate (path g v1 v4) `shouldThrow`  (errorCall "Prelude.head: empty list")

    describe "connectedComponents" $ do
        it "should return the connected components" $ do
            (connectedComponents g) `shouldBe` [[v4],[v3, v2, v1],[v0]]

    describe "getVertecies" $ do
        it "should return all vertecies" $ do
            (getVertecies g) `shouldBe` [v0, v1, v2, v3, v4]

    describe "getEdges" $ do
        it "should return all edges" $ do
            (getEdges g) `shouldBe` [e1, e2]

    describe "addVertex" $ do
        it "should add a vertex" $ do
            let insert = mkVertex 10
            getVertecies (addVertex g insert) `shouldBe` [insert, v0, v1, v2, v3, v4]

    describe "removeVertex" $ do
        it "should remove a vertex" $ do
            getVertecies (removeVertex g v4) `shouldBe` [v0, v1, v2, v3]

        it "should remove edges the vertex belongs to" $ do
            getEdges (removeVertex g v2) `shouldBe` []
    
    describe "addEdge" $ do
        it "should add an edge" $ do
            let insert = mkEdge v1 v4
            getEdges (addEdge g insert) `shouldBe` [insert, e1, e2]

    describe "removeEdge" $ do
        it "should remove the edge" $ do
            getEdges (removeEdge g e1) `shouldBe` [e2]