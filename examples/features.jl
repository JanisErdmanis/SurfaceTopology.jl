# # Intorduction

# As we know triangular meshes can be stored in a computer in a multiple different ways, each having strength and weaknesses in a particular cases. Not always it is clear which datastructure would be most performant for a numerical algorithm so it is wise to write a datastructure generic code. This package is exactly for that purpose for orriented closed surfaces. 

# The simplest representation of triangular mesh topology is in array `Array{Faces{3,Int},1}` containing a list of triangular faces which are defined by their vertices. Often in a numerical code one wants not only to iterate over faces or vertices, but also in case of singularity substraction, integration and local property estimation like normal vectors and curvature to know what are neighbouring verticies surrounding a given vertex while keeping track of orrientation of the normals. Also one wishes to modify the topology itself by colloapsing, flipingn and splitting edges. This is why different datstructrures are needed for different problems.

# Fortunatelly it is possible to abstract queries of the topology through iterators:
# ```@docs
# Faces
# Edges
# ```
# and circulators:
# ```@docs
# VertexRing
# EdgeRing
# ```


# ## API

# At the moment the package implements three different kinds of datastructures. The simplest one is `PlainDS` one which stores list of faces and is just an alias to `Array{Faces{3,Int},1}`. As an example how taht works let's deffine the datastructure: 

using GeometryTypes
using SurfaceTopology

faces = Face{3,Int64}[
    [1, 12, 6], [1, 6, 2], [1, 2, 8], [1, 8, 11], [1, 11, 12], [2, 6, 10], [6, 12, 5], 
    [12, 11, 3], [11, 8, 7], [8, 2, 9], [4, 10, 5], [4, 5, 3], [4, 3, 7], [4, 7, 9],  
    [4, 9, 10], [5, 10, 6], [3, 5, 12], [7, 3, 11], [9, 7, 8], [10, 9, 2] 
]

# The datastructure `faces` can be directly used for the queries. The iterators can be executed:
collect(Faces(faces))
# and
collect(Edges(faces))
# giving us desirable output.

# The circulators which for this simple datastructure requires to do a full lookup on the array can simply be executed as:
collect(VertexRing(3,faces))
# and
collect(EdgeRing(3,faces))
# In practice one should use `EdgeRing` over `VertexRing` since in the later one vertices are not ordered. 

# ## Datastructures

# The same API works for all other datastructures. There is a datastructure `CachedDS` built on top of `PlainDS` stores closest vertices (vertex ring). Then there is a datastructure `FaceDS` which with `PlainDS` also stores neighbouring faces which have a common edge. And then there are most popular datastructures `HalfEdgeDS` (implemented as `EdgeDS`).

# The simplest extension is just a plain caching implemented under `CacheDS` which for each vertex stores it's surrounding verticies.
# ```@docs
# CachedDS
# CachedDS(::SurfaceTopology.PlainDS)
# ```
# which can be initialised from `PlainDS`
cachedtopology = CachedDS(faces)
# And the same API can be used for querries:
collect(VertexRing(3,cachedtopology))

# A more advanced datastructure is a face based datastructure which in this library is defined as `FaceDS` which additionally for each face stores 3 neigbouring face indicies.
# ```@docs
# FaceDS
# FaceDS(::SurfaceTopology.PlainDS)
# ```
# which again can be initialised from `PlainDS`
facedstopology = FaceDS(faces)
# and what would one expect
collect(VertexRing(3,facedstopology))
# works.

# The last in the list is half edge datastructure `EdgeDS` which stores edges with three numbers - base vertex index, next edge index and twin edge index.
# ```@docs
# EdgeDS
# ```
# To initiate this datastructure one executes:
edgedstopology = EdgeDS(faces)
# 
collect(VertexRing(3,edgedstopology))

# ## Wishlist

# At the moment the package is able to only answer queries, but it would be desirable to also be able to do topological operations. For completition thoose would include:

#   + `edgeflip(topology,edge)`
#   + `edgesplit(topology,edge)`
#   + `edgecollapse(topology,edge)`

# And with them also a method for `defragmenting` the topology. Unfortunatelly due to irrelevance of this package for my present research, the development of that on my own will be slow. I hope that clarity and simplicity of this package could serve someone as a first step and so eventually topological operations would be impemented out of necessity.
