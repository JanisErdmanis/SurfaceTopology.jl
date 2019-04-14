# SurfaceTopology.jl

A package for performing lookup and manipulations (not implemented) for triangular meshes.

## How is it usefull?

As we know triangular meshes can be stored in a computer in a multiple different ways, each having strength and weaknesses in a particular cases. Not always it is clear which datastructure would be most performant for a numerical algorithm so it is wise to write a datastructure generic code. This package is exactly for that purpose. 

The simplest representation of topology is in array `Array{Faces{3,Int},1}` for which the name `PlainDS` is given. Then there is a datastructure built on top of that `CachedDS` which with `PlainDS` also stores closest vertices (vertex ring). Then there is a datastructure `FaceDS` which with `PlainDS` also stores neighbouring faces which have a common edge. And then there are most popular datastructures `HalfEdgeDS` and `WingedEdgeDS` which are not implemented (pull requests and help welcome). 

The lookup operations implemented are
    + `Faces(topology)` an iterable over faces
    + `Edges(topology)` an iterable over edges
    + `VertexRing(topology,v)` an iterable over vertices around `v`
    + `EdgeRing(topology,v)` an iterable over ring edges around `v`
There is also `FaceRing(topology,v)` returning iterable over face index with common `v`, which I have never used and seems to be ambigious for edge data structures. Thus it might be removed from this package.

At the moment no topological operations are implemented in this package. Highly desirable methods are
   + `edgeflip(topology,edge)`
   + `edgesplit(topology,edge)`
   + `edgecollapse(topology,edge)`
which I hope will eventually settle in this package.

