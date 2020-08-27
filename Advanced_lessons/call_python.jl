#Now we are getting to some interesting stuff

# This would install and create a new miniconda environment, since I don't want to reinstall miniconda, i'll create the new environment myself
# using Pkg
# Pkg.add("PyCall")
# using PyCall

#Miniconda create env documentation here:
#super simple, use conda create --name miniconda_julia
#miniconda_julia being my environment name

#Testing if new conda environment works

using Pkg

ENV["PYTHON"]=""
ENV["miniconda_julia"]="miniconda3"#This is the path to miniconda3

Pkg.add("Conda")
using Conda

Pkg.add("PyCall")
Pkg.build("PyCall")
using PyCall

math=pyimport("math")
println(math.sin(3))

#This is great, so cool, love it.

