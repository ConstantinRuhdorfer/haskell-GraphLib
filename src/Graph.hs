module Graph where

import Debug.Trace

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

path :: Graph -> Vertex -> Vertex -> Vertecies
path g@(Graph vertecies []) start goal = []
path graph start goal 
    | start == goal = [goal]
    | otherwise = path' graph start goal [] []

path' :: Graph -> Vertex -> Vertex -> Vertecies -> Vertecies -> Vertecies
path' graph current goal visited open 
    | goal `elem` neighbours = reverse (goal:newVisited)
    | otherwise = path' graph (head newOpen) goal newVisited (tail newOpen)
        where
            newOpen = filter (\v -> not (elem v visited)) (neighbours ++ open)
            newVisited = current:visited
            neighbours = getNeighbours graph current
      