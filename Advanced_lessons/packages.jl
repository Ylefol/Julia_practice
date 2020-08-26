# typed ] in repo and named it TestPackage1, pressend enter, that's it

# using Pkg
# Pkg.activate("TestPackage1")

# using TestPackage1
# TestPackage1.greet()    #will print hello world


#Now we can add dependencies
#Modified the TestPackage1.jl file a bit


using Pkg
Pkg.activate("TestPackage1")

using TestPackage1
println(TestPackage1.mySpecialFunction(42))

# To add SpecialFunctions to package I needed to do the following
# type ] in REPL, type `activate TestPackage1`
# Then I could type `add SpecialFunctions`


#to install all dependencies of the package we can use instantiate

using Pkg
Pkg.instantiate
