module Graph
    ( Graph
    , mkGraph
    , addVertex
    , removeVertex
    , addEdge
    , removeEdge
    , path
    , connectedComponent
    , connectedComponents
    ) where

import Vertex
import Edge

data Graph = Graph 
    { vertecies :: Vertecies
    , edges :: Edges
    } deriving (Show)


mkGraph :: Vertecies -> Edges -> Graph
mkGraph vertecies edges = Graph vertecies edges

addVertex :: Graph -> Vertex -> Graph
addVertex (Graph vertecies edges) vertex = mkGraph (vertex:vertecies) edges

removeVertex :: Graph -> Vertex -> Graph
removeVertex (Graph [] edges) _ = mkGraph [] edges
removeVertex (Graph vertecies edges) vertex 
    = mkGraph (filter (\v -> v /= vertex) vertecies) 
              (filter (\e -> (getVertexA e) /= vertex 
                && (getVertexB e) /= vertex) edges)

addEdge :: Graph -> Edge -> Graph
addEdge (Graph vertecies edges) edge = mkGraph vertecies (edge:edges)

removeEdge :: Graph -> Edge -> Graph
removeEdge (Graph vertecies []) _ = mkGraph vertecies []
removeEdge (Graph vertecies edges) edge 
    = mkGraph vertecies (filter (\e -> e /= edge) edges)

getNeighbours :: Graph -> Vertex -> Vertecies
getNeighbours (Graph _ []) _ = []
getNeighbours (Graph _ edges) vertex 
    = map (\e -> getOtherVertex e vertex) 
          (filter (\e -> occursInEdge e vertex) edges)

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

path :: Graph -> Vertex -> Vertex -> Vertecies
path (Graph _ []) _ _ = []
path graph start goal 
    | start == goal = [goal]
    | otherwise = reverse (goal:(depthFirstSearch graph start (\open -> goal `elem` open)))

connectedComponent :: Graph -> Vertex -> Vertecies
connectedComponent (Graph [] _) _ = []
connectedComponent graph startVertex 
    = depthFirstSearch graph startVertex (\open -> open == [])

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