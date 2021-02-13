export
    VMDMolecule,
    writemol!

mutable struct VMDMolecule
    molid::Union{Int, String}
    reps::Vector{Representation}
    graphics::Vector{Graphics}
    show::Bool
    active::Bool
    fix::Bool
end # struct

function VMDMolecule(;
                     molid = "top",
                     reps = Representation[],
                     graphics = Graphics[],
                     show = true,
                     active = true,
                     fix = false)
    VMDMolecule(molid, reps, graphics, show, active, fix)
end # function

function writemol!(io, mol::VMDMolecule)
    for (repid, rep) in enumerate(mol.reps)
        writerep!(io, mol.molid, repid - 1, rep)
    end # for
    for g in mol.graphics
        writegraphics!(io, mol.molid, g)
    end # for
end # function

function addrep!(mol::VMDMolecule, rep::Representation)
    push!(mol.reps, rep)
end # function

function addgraphics!(mol::VMDMolecule, graphics::Graphics)
    push!(mol.graphics, graphics)
end # function
