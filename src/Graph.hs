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
addVertex g@(Graph vertecies edges) vertex = mkGraph (vertex:vertecies) edges

removeVertex :: Graph -> Vertex -> Graph
removeVertex g@(Graph [] edges) vertex = mkGraph [] edges
removeVertex g@(Graph vertecies edges) vertex 
    = mkGraph (filter (\v -> v /= vertex) vertecies) 
              (filter (\e -> (getVertexA e) /= vertex 
                && (getVertexB e) /= vertex) edges)

addEdge :: Graph -> Edge -> Graph
addEdge g@(Graph vertecies edges) edge = mkGraph vertecies (edge:edges)

removeEdge :: Graph -> Edge -> Graph
removeEdge g@(Graph vertecies []) edge = mkGraph vertecies []
removeEdge g@(Graph vertecies edges) edge 
    = mkGraph vertecies (filter (\e -> e /= edge) edges)

getNeighbours :: Graph -> Vertex -> Vertecies
getNeighbours g@(Graph _ []) vertex = []
getNeighbours g@(Graph _ edges) vertex 
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
path g@(Graph vertecies []) start goal = []
path graph start goal 
    | start == goal = [goal]
    | otherwise = result
  where
    result = goal:(depthFirstSearch graph start (\open -> goal `elem` open))

connectedComponent :: Graph -> Vertex -> Vertecies
connectedComponent g@(Graph [] _) vertex = []
connectedComponent graph startVertex 
    = depthFirstSearch graph startVertex (\open -> open == [])

connectedComponents :: Graph -> [Vertecies]
connectedComponents g@(Graph [] []) = [[]]
connectedComponents g@(Graph vertecies []) = map (\v -> [v]) vertecies
connectedComponents g@(Graph vertecies _) 
    = foldl 
        (\list vertex -> 
            if not(vertex `elem` (concat list)) then (connectedComponent g vertex):list 
            else list) 
        [] 
        vertecies