module Vertex 
    ( Vertex
    , Vertecies
    , mkVertex
    , getVertexId
) where

type VertexId = Int

data Vertex = Vertex 
    { vertexId :: VertexId
    } deriving (Eq, Show)  

type Vertecies = [Vertex]

mkVertex :: VertexId -> Vertex
mkVertex id 
    | id >= 0 = Vertex id

getVertexId :: Vertex -> VertexId
getVertexId = vertexId

