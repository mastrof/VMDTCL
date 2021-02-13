export
    TCLScript,
    writetcl

struct TCLScript{T<:AbstractVector{VMDMolecule}}
    molecules::T
end # for

function writetcl(io, tcl::TCLScript)    
    script = ["menu main on"]
    for mol in tcl.molecules
        writemol!(script, mol)
    end # for
    write(io, join(script, '\n'))
end # function
