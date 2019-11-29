module Main where

import Graph
import Vertex
import Edge

v_0 = mkVertex 0
v_1 = mkVertex 1
v_2 = mkVertex 2
v_3 = mkVertex 3

e_0 = mkEdge v_0 v_1
e_1 = mkEdge v_1 v_2
e_2 = mkEdge v_2 v_3

g_0 = mkGraph [v_0, v_1, v_2, v_3] [e_0, e_1, e_2]

result = path g_0 v_0 v_3

main :: IO ()
main = print result
