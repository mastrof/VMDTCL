export
    AbstractGeometry,
    Point,
    Sphere,
    Cylinder,
    Cone,
    Triangle,
    Line,
    Text,
    Graphics,
    addgeometry!,
    addgraphics!,
    writegeometry!,
    writegraphics!


abstract type AbstractGeometry end

struct Point{T<:AbstractVector} <: AbstractGeometry
    r::T
end # struct

Point(r = zeros(3)) = Point(r)

struct Sphere{T<:AbstractVector,S<:Real} <: AbstractGeometry
    center::T
    radius::S
    res::Int
end # struct

function Sphere(; center = zeros(3), radius = 1, res = 80)
    Sphere(center, radius, res)
end # function
    
struct Cylinder{T<:AbstractVector,S<:Real} <: AbstractGeometry
    r1::T
    r2::T
    radius::S
    res::Int
    fill::Symbol
end # struct

function Cylinder(; r1 = zeros(3), r2 = ones(3), radius = 1,
                  res = 80, fill = :yes)
    Cylinder(r1, r2, radius, res, fill)
end # function

struct Cone{T<:AbstractVector,S<:Real} <: AbstractGeometry
    base::T
    tip::T
    radius::S
    res::Int
end # struct

function Cone(; base = zeros(3), tip = ones(3), radius = 1, res = 80)
    Cone(base, tip, radius, res)
end # function

struct Triangle{T<:AbstractVector} <: AbstractGeometry
    r1::T
    r2::T
    r3::T
end # struct

function Triangle(; r1 = [1.,0.,0.], r2 = [0.,1.,0.], r3 = [0.,0.,1.])
    Triangle(r1, r2, r3)
end # function

struct Line{T<:AbstractVector,S<:Real} <: AbstractGeometry
    r1::T
    r2::T
    width::S
    style::Symbol
end # struct

function Line(; r1 = zeros(3), r2 = ones(3), width = 2, style = :solid)
    Line(r1, r2, width, style)
end # function

struct Text{T<:AbstractVector} <: AbstractGeometry
    r::T
    text::String
    size::Int
    thickness::Int
end # struct

function Text(; r = zeros(3), text = "text", size = 5, thickness = 5)
    Text(r, text, size, thickness)
end # function


struct Graphics
    color::Union{Int, String}
    material::String
    geometries::Vector{AbstractGeometry}
end # struct

function Graphics(;
                  color = 0,
                  material = "AOChalky",
                  geometries = AbstractGeometry[])
    Graphics(color, material, geometries)
end # function

function addgeometry!(g::Graphics, geometry::T) where T<:AbstractGeometry
    push!(g.geometries, geometry)
end # function

function writegeometry!(io, molid, geom::Sphere)
    r = join(geom.center, ' ')
    push!(io,
          "graphics $molid sphere {$r} radius $(geom.radius) " *
          "resolution $(geom.res)")
end # function

function writegeometry!(io, molid, geom::Cylinder)
    r1 = join(geom.r1, ' ')
    r2 = join(geom.r2, ' ')
    push!(io,
          "graphics $molid cylinder {$r1} {$r2} radius $(geom.radius) " *
          "resolution $(geom.res) filled $(geom.fill)")
end # function

function writegeometry!(io, molid, geom::Cone)
    base = join(geom.base, ' ')
    tip = join(geom.tip, ' ')
    push!(io,
          "graphics $molid cone {$base} {$tip} radius $(geom.radius) " *
          "resolution $(geom.res)")
end # function

function writegeometry!(io, molid, geom::Triangle)
    r1 = join(geom.r1, ' ')
    r2 = join(geom.r2, ' ')
    r3 = join(geom.r3, ' ')
    push!(io, "graphics $molid triangle {$r1} {$r2} {$r3}")
end # function

function writegeometry!(io, molid, geom::Line)
    r1 = join(geom.r1, ' ')
    r2 = join(geom.r2, ' ')
    push!(io,
          "graphics $molid line {$r1} {$r2} " *
          "width $(geom.width) style $(geom.style)")
end # function

function writegeometry!(io, molid, geom::Point)
    r = join(geom.r, ' ')
    push!(io, "graphics $molid point {$r}")
end # function

function writegraphics!(io, molid, graphics)
    push!(io, "graphics $(molid) color $(graphics.color)")
    push!(io, "graphics $(molid) material $(graphics.material)")
    for geometry in graphics.geometries
        writegeometry!(io, molid, geometry)
    end # for
end # function
