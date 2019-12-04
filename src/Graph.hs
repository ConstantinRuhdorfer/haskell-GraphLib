module Graph
    ( Graph
    , mkGraph
    , addVertex
    , removeVertex
    , getVertecies
    , addEdge
    , removeEdge
    , getEdges
    , getNeighbours
    , path
    , connectedComponents
    ) where

import Vertex
import Edge

{-|
  'Graph' datatype that represents a graph with list of edges and a list of vertecies.
-}
data Graph = Graph 
    { vertecies :: Vertecies
    , edges :: Edges
    } deriving (Eq, Show)

{-|
  Constructor for a Graph.
-}
mkGraph :: Vertecies -> Edges -> Graph
mkGraph vertecies edges = Graph vertecies edges

{-|
  The 'getNeighbours' function returns the neighbours of a vertex.
-}
getNeighbours :: Graph -> Vertex -> Vertecies
getNeighbours (Graph _ []) _ = []
getNeighbours (Graph _ edges) vertex 
    = map (\e -> getOtherVertex e vertex) 
          (filter (\e -> occursInEdge e vertex) edges)

{-|
  The 'depthFirstSearch' function does a DFS until the stopping criteria is reached.
  path is a wrapper for 'depthFirstSearch''.
-}
depthFirstSearch :: Graph -> Vertex -> (Vertecies -> Bool) -> Vertecies
depthFirstSearch graph start stopCond 
    = depthFirstSearch' graph start stopCond [] [start]

depthFirstSearch' :: Graph -> Vertex -> (Vertecies -> Bool) -> Vertecies -> Vertecies -> Vertecies
depthFirstSearch' graph current stopCond visited open
    | stopCond open = visited
    | otherwise = depthFirstSearch' graph (head newOpen) stopCond newVisited newOpen
  where
    newOpen = filter (\v -> not (elem v newVisited)) (neighbours ++ open)
    newVisited = current:visited
    neighbours = getNeighbours graph current

{-|
  The 'path' function returns a path from vertex a to vertex b.
  path is a wrapper for 'depthFirstSearch'.
-}
path :: Graph -> Vertex -> Vertex -> Vertecies
path (Graph _ []) _ _ = []
path graph start goal 
    | start == goal = [goal]
    | otherwise = reverse (goal:(depthFirstSearch graph start (\open -> goal `elem` open)))

{-|
  The 'connectedComponent' function returns all reachable 
  vertecies from the start vertex inclduging the start.
  connectedComponent is a wrapper for 'depthFirstSearch'.

  E. g. given g with vertecies [1,2,3,4,5], edges [1-2,2-3,4-5] 
  and start vertex 1 returns [1,2,3] 
-}
connectedComponent :: Graph -> Vertex -> Vertecies
connectedComponent (Graph [] _) _ = []
connectedComponent graph startVertex 
    = depthFirstSearch graph startVertex (\open -> open == [])

{-|
  The 'connectedComponents' function returns all connected components as a list of lists.

  E. g. given g with vertecies [1,2,3,4,5] and edges [1-2,2-3,4-5] returns [[1,2,3],[4,5]]  
-}
connectedComponents :: Graph -> [Vertecies]
connectedComponents (Graph [] []) = [[]]
connectedComponents (Graph vertecies []) = map (\v -> [v]) vertecies
connectedComponents g@(Graph vertecies _) 
    = foldl 
        (\list vertex -> 
            if not(vertex `elem` (concat list)) then (connectedComponent g vertex):list 
            else list) 
        [] 
        vertecies

-- Basic comfort functions:

addVertex :: Graph -> Vertex -> Graph
addVertex (Graph vertecies edges) vertex = mkGraph (vertex:vertecies) edges

removeVertex :: Graph -> Vertex -> Graph
removeVertex (Graph [] edges) _ = mkGraph [] edges
removeVertex (Graph vertecies edges) vertex 
    = mkGraph (filter (\v -> v /= vertex) vertecies) 
                (filter (\e -> (getVertexA e) /= vertex 
                && (getVertexB e) /= vertex) edges)

getVertecies :: Graph -> Vertecies
getVertecies = vertecies

addEdge :: Graph -> Edge -> Graph
addEdge (Graph vertecies edges) edge = mkGraph vertecies (edge:edges)

removeEdge :: Graph -> Edge -> Graph
removeEdge (Graph vertecies []) _ = mkGraph vertecies []
removeEdge (Graph vertecies edges) edge 
    = mkGraph vertecies (filter (\e -> e /= edge) edges)

getEdges :: Graph -> Edges
getEdges = edges