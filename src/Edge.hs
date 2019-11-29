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
    } deriving (Eq)

type Edges = [Edge]

instance Show Edge where
    show (Edge vertexA vertexB) = "e(" ++ show(vertexA) ++ " > " ++ show(vertexB) ++ ")"

mkEdge :: Vertex -> Vertex -> Edge
mkEdge vertexA vertexB = Edge vertexA vertexB

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
