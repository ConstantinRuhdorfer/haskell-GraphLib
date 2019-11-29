module Main where

import Graph
import Vertex
import Edge

import System.IO

main :: IO ()
main  = do  
    let list = []
    handle <- openFile "input/graph1.plain" ReadMode
    contents <- hGetContents handle
    let singlewords = words contents
        list = f singlewords
    
    let graphVertecies = parseInputVertecies (head list) []
    let graphEdges = parseInputEdges (tail list) []

    let g = mkGraph graphVertecies graphEdges

    let res = connectedComponents g

    print res

    hClose handle

parseInputEdges :: [Int] -> Edges -> Edges
parseInputEdges list result
    | list == [] = result
    | otherwise = parseInputEdges (tail (tail list)) (partSolution:result) 
  where
    vertexA = mkVertex (head list)
    vertexB = mkVertex (head (tail list))
    partSolution = mkEdge vertexA vertexB

parseInputVertecies :: Int -> Vertecies -> Vertecies
parseInputVertecies numVertecies result
    | numVertecies == 0 = result
    | otherwise = parseInputVertecies (numVertecies-1) ((mkVertex (numVertecies-1)):result)


f :: [String] -> [Int]
f = map read