module Vertex 
    ( Vertex
    , Vertecies
    , mkVertex
    , getVertexId
) where

type VertexId = Int

{-|
  'Vertex' datatype that represents a vertex in the graph.
  It just wraps an non-negative int.
-}
data Vertex = Vertex 
    { vertexId :: VertexId
    } deriving (Eq)  

{-|
  A nice shorthand type for a list of vertecies.
-}
type Vertecies = [Vertex]

{-|
  "Overrides" the show method for Vertex.

  E. g. Vertex(1) -> v_1 
-}
instance Show Vertex where
    show (Vertex _id) = "v_" ++ show(_id)

{-|
  Constructor for a Vertex.
-}
mkVertex :: VertexId -> Vertex
mkVertex newId 
    | newId >= 0 = Vertex newId
    | otherwise = error "Should not be negative"

-- Basic comfort functions:

getVertexId :: Vertex -> VertexId
getVertexId = vertexId

