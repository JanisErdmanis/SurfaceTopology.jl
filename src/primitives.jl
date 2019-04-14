const PlainDS = Array{Face{3,Int},1}

struct FaceRing{T}
    v::Int
    t::T # topology
end

struct EdgeRing{T}
    v::Int
    t::T # topology
end

struct VertexRing{T}
    v::Int
    t::T # topology
end

function Base.collect(iter::Union{FaceRing,VertexRing})
    collection = Int[] 
    for i in iter
        push!(collection,i)
    end
    return collection
end

function Base.collect(iter::EdgeRing)
    collection = Face{2,Int}[] 
    for i in iter
        push!(collection,i)
    end
    return collection
end

### There is a room for unstructured circulators iterators for performance reasons.

function find_other_triangle_edge(v1::Integer,v2::Integer,skip::Integer,t::PlainDS) 
    for i in 1:length(t)
        if in(v1,t[i]) & in(v2,t[i]) & !(i==skip)
            return i
        end
    end
    return -1
end

function find_triangle_vertex(v::Integer,t::PlainDS) 

    for i in 1:length(t)
        if in(v,t[i])
            return i
        end
    end
    return length(t) + 1 # -1
end
