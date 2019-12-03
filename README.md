# haskell-GraphLib

A small graph lib written in Haskell.

This is modeld after https://github.com/DanielWochnik/CombOptWS2018.
The input files also come from this repo.

## Project structure

The relevant folders are:

```
.
+-- src/                  Src files are here
|   +-- Edge.hs
|   +-- Graph.hs
|   +-- Main.hs
|   +-- Parser.hs
|   +-- Vertex.hs
+-- input/                Some sample input files are here
```

## Usage

A basic project setup looks like this (assumes the haskell-stack toolchain):

```sh
git clone git@github.com:ConstantinRuhdorfer/haskell-GraphLib.git
cd haskell-GraphLib
stack install
./build.sh
```

After that you can compile and run the programm with:

```sh
./build.sh
```

or (but really the same):

```sh
stack build
stack exec haskell-GraphLib some/path/to/problem/File
```

## Command-Line arguments

Notice that the program accepts a path to a problem file.
Some examples are:

```sh
stack exec haskell-GraphLib input/graph1.plain
```

or:

```sh
stack exec haskell-GraphLib path/to/project/input/graph1.plain
```

## Input file format

The input file need to look like this:

```sh
9      Number of vertecies on the first line: Will create vertex 0 .. 8
0 1    After that list of edges with: id1 id2.
0 2    Notice: No sanity checks are performed on the edges.
0 6
1 5
1 6
2 5
3 5
3 6
4 7
```
