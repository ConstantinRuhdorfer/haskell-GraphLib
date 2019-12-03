module Edge 
    ( Edge
    , Edges
    , mkEdge
    , getOtherVertex
    , getVertexA
    , getVertexB
    , occursInEdge
    ) where

import Vertex

{-|
  'Edge' datatype that represents a edge in the graph.
  Edges are undirected.
-}
data Edge = Edge 
    { vertexA :: Vertex
    , vertexB :: Vertex
    } deriving (Eq)

{-|
  A nice shorthand type for a list of edges.
-}
type Edges = [Edge]

{-|
  "Overrides" the show method for Edge.

  E. g. Edge(1, 2) -> e(1 - 2) 
-}
instance Show Edge where
    show (Edge vertexA vertexB) = "e(" ++ show(vertexA) ++ " - " ++ show(vertexB) ++ ")"

{-|
  Constructor for a Edge.
-}
mkEdge :: Vertex -> Vertex -> Edge
mkEdge vertexA vertexB = Edge vertexA vertexB

-- Basic comfort functions:

getOtherVertex :: Edge -> Vertex -> Vertex
getOtherVertex (Edge a b) vertex 
    | vertex == a = b
    | otherwise = a

getVertexA :: Edge -> Vertex
getVertexA = vertexA

getVertexB :: Edge -> Vertex
getVertexB = vertexB

occursInEdge :: Edge -> Vertex -> Bool
occursInEdge (Edge a b) vertex = vertex == a || vertex == b
