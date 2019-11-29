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

data Edge = Edge 
    { vertexA :: Vertex
    , vertexB :: Vertex
    } deriving (Eq, Show)

type Edges = [Edge]


mkEdge :: Vertex -> Vertex -> Edge
mkEdge vertexA vertexB = Edge vertexA vertexB

getOtherVertex :: Edge -> Vertex -> Vertex
getOtherVertex e@(Edge a b) vertex 
    | vertex == a = b
    | otherwise = a

getVertexA :: Edge -> Vertex
getVertexA = vertexA

getVertexB :: Edge -> Vertex
getVertexB = vertexB

occursInEdge :: Edge -> Vertex -> Bool
occursInEdge e@(Edge a b) vertex = vertex == a || vertex == b
