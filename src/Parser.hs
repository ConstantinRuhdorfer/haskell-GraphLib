module Parser 
    ( parseInputEdges
    , parseInputVertecies
    , strToInt
) where

import Vertex
import Edge

{-|
  The 'parseInputEdges' function makes a list of edges from a list of ints.
  Every two pairs of int will make a new Edge.
  parseInputEdges is a wrapper for parseInputEdges'.

  E. g. [1,2,3,4] -> [Edge(1,2), Edge(3,4)]
-}
parseInputEdges :: [Int] -> Edges
parseInputEdges list = parseInputEdges' list []

parseInputEdges' :: [Int] -> Edges -> Edges
parseInputEdges' list result
    | list == [] = result
    | otherwise = parseInputEdges' (tail (tail list)) (partSolution:result) 
  where
    vertexA = mkVertex (head list)
    vertexB = mkVertex (head (tail list))
    partSolution = mkEdge vertexA vertexB

{-|
  The 'parseInputVertecies' function makes a list of vertecies from a integer.
  parseInputVertecies is a wrapper for parseInputVertecies'.

  E. g. 3 -> [Vertex(0), Vertex(1), Vertex(2)]
-}
parseInputVertecies :: Int -> Vertecies
parseInputVertecies list = parseInputVertecies' list []

parseInputVertecies' :: Int -> Vertecies -> Vertecies
parseInputVertecies' numVertecies result
    | numVertecies == 0 = result
    | otherwise = parseInputVertecies' (numVertecies-1) ((mkVertex (numVertecies-1)):result)

{-|
  The 'strToInt' takes a list of strings and maps them to a list of Ints.

  E. g. ["1", "2", "3"] -> [1, 2, 3]
-}
strToInt :: [String] -> [Int]
strToInt = map read