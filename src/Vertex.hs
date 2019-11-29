module Vertex 
    ( Vertex
    , Vertecies
    , mkVertex
    , getVertexId
) where

type VertexId = Int

data Vertex = Vertex 
    { vertexId :: VertexId
    } deriving (Eq)  

type Vertecies = [Vertex]

instance Show Vertex where
    show (Vertex _id) = "v_" ++ show(_id)

mkVertex :: VertexId -> Vertex
mkVertex newId 
    | newId >= 0 = Vertex newId
    | otherwise = error "Should not be negative"

getVertexId :: Vertex -> VertexId
getVertexId = vertexId

