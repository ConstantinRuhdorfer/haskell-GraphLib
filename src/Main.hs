module Main where

import Graph
import Parser
import Vertex

import System.IO
import System.Environment

main :: IO ()
main  = do
    let list = []

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
    handle <- openFile path ReadMode
    contents <- hGetContents handle
    let singlewords = words contents
        list = strToInt singlewords
    
    let graphVertecies = parseInputVertecies (head list)
    let graphEdges = parseInputEdges (tail list)

    let g = mkGraph graphVertecies graphEdges

    -- At this point you have obtained a graph; Do something with it!
    -- Calcs connected components:
    let res = connectedComponents g

    print res

    hClose handle