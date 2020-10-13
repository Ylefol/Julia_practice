#Bio julia, the way it works
#Originally there was bio.jl which was 
#a sort of wrapper for all bioinformatic packages
#now that there are too many, the wrapper is obsolete
#so now to download biojulia packages I should
#download individual packages.


#The website below provides somewhat of a tutorial 
#for biosequences in julia
#https://towardsdatascience.com/getting-familiar-with-biojulia-bioinformatics-for-julia-796438aa059
#Just did Pkg add on a bunch of em.

Pkg.add("BioCore")
Pkg.add("BioSymbols")
Pkg.add("GenomeGraphs")
Pkg.add("BioGenerics")
Pkg.add("BigBed")
Pkg.add("BioSequences")
Pkg.add("XAM")


#Work with some pangolin stuff from USBC