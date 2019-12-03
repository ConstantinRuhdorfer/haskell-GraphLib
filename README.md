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
stack init
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
stack exec haskell-GraphLib
```
