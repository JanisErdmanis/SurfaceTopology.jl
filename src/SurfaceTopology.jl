module SurfaceTopology

using GeometryTypes

include("primitives.jl")
include("plainds.jl")
include("faceds.jl")
include("cachedds.jl")

export FaceDS, CachedDS
export FaceRing, VertexRing, EdgeRing
export Edges,Faces

end # module

