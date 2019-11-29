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
getOtherVertex edge vertex | vertex == vertexA edge = vertexB edge
                           | otherwise = vertexA edge

getVertexA :: Edge -> Vertex
getVertexA edge = vertexA edge

getVertexB :: Edge -> Vertex
getVertexB edge = vertexB edge

occursInEdge :: Edge -> Vertex -> Bool
occursInEdge edge vertex | vertex == vertexA edge = True
                         | vertex == vertexB edge = True
                         | otherwise = False
