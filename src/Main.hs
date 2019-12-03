module Main where

import Graph
import Parser
import Vertex

import System.IO

main :: IO ()
main  = do  
    let list = []
    -- Could be any of the files in input/*
    -- Notice: Some of the files are *big*
    handle <- openFile "input/graph1.plain" ReadMode
    contents <- hGetContents handle
    let singlewords = words contents
        list = strToInt singlewords
    
    let graphVertecies = parseInputVertecies (head list)
    let graphEdges = parseInputEdges (tail list)

    let g = mkGraph graphVertecies graphEdges

    -- Searches for all connected components
    let res = connectedComponents g

    let path0to6 = path g (mkVertex 0) (mkVertex 5)

    print path0to6

    hClose handle