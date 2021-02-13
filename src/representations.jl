export
    Representation,
    addrep!,
    writerep!

mutable struct Representation
    select::String
    color::String
    material::String
    style::String
end # struct

function Representation(;
                        select = "all",
                        color = "Name",
                        material = "AOChalky",
                        style = "CPK")
    Representation(select, color, material, style)
end # function

function writerep!(io, molid, repid, rep)
    push!(io, "mol addrep $(molid)")
    push!(io,
          "mol modselect $(repid) $(molid) $(rep.select)")
    push!(io,
          "mol modcolor $(repid) $(molid) $(rep.color)")
    push!(io,
          "mol modmaterial $(repid) $(molid) $(rep.material)")
    push!(io,
          "mol modstyle $(repid) $(molid) $(rep.style)")
end # function

