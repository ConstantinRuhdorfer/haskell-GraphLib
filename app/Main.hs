module Main where

import Graph
import Parser
import Vertex

import System.IO
import System.Environment

main :: IO ()
main  = do
    args <- getArgs
    case args of
        [] ->    print "Please give atleast one command line argument like: ... input/graph1.plain"
        [arg] -> handleFilePath arg 
        _ ->     error "too many arguments just 1 supported."

{-|
  The 'handleFilePath' function gets a file path and does something with it.
  Put your code here:
-}
handleFilePath :: String -> IO ()
handleFilePath path = do
    let list = []
    handle <- openFile path ReadMode
    contents <- hGetContents handle
    let singlewords = words contents
        list = strToInt singlewords
    
    let graphVertecies = parseInputVertecies (head list)
    let graphEdges = parseInputEdges (tail list)

    let g = mkGraph graphVertecies graphEdges

    -- At this point you have obtained a graph; Do something with it!
    -- Have a look at Graph.hs for algorithms
    -- Calcs connected components:
    let res = connectedComponents g

    let edges = getEdges g
    let vertecies = getVertecies g

    print "Edges: "
    print edges
    print "Vertecies: "
    print vertecies
    print "Connected compononents:"
    print res

    hClose handle