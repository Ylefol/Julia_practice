#Arrays are a bit funky in Julia as in the way we can create them is odd, but cool

a=[1,2,3]   #This is a column vector, note that it has commas separating the values
b=[4,5,6]   #This is another column vector

#a*b will yield an error as we are trying to put two column vectors instead of one column and one row

c=[4 5 6]   #This is a row vector, note the absence of commas

println(a*c) #This works as expected

println(c*a) #mathematically this output makes sense
#what the above does is the following math ((4*1)+(5*2)+(6*3))=32

# However broadcasting was created to help indicate the action that is to be done

println(a.*c)
println(c.*a)   #Note that both of these now give the same result

#broadcasting can be used in several different ways, such as applying a function to each element of a tuple
a=[1,2,3]

# println(sin(a)) #This causes an error

println(sin.(a))  #This performs the action we intended with the above println


#reached variable scope of the tutorial

# learning about let and local scope
a=let 
    i=3
    i=+5
    i
end
println(a)
# println(i) # i is not defined

# constant variables in Julia cannot be type changed
const C = 333333
C =66666
# C=2.55 # this will raise an error

#modules, a variable within a module will not be available outside that module

module ScopeTestModule
    export a1
    a1=25
    b1=42
end

using .ScopeTestModule
println(a1)
# println(b1) #This will raise an error

println(ScopeTestModule.b1)
# ScopeTestModule.b1=26   #this will raise an error as the b1 variable cannot be modified from outside the module of ScopeTestModule

#modules are essentially libraries!
#in julia, to install and use a module (library) we need to use the Pkg package manager

using Pkg
Pkg.add("SpecialFunctions")

using SpecialFunctions
#using is essentially import, however we can't do using 'as' so it is wiser to use the library name followed by function name
#this is just incase there are other packages in use that have identical function names
#Julia will (normally) say if there are conflicting names

#There is also the import function in Julia, however there is still no 'as'. 
# The distinction between import and using is that 'using' exports the functions in the calling scope
# Another way to word it is that 'using' will only allow us to use what is exported from the module while import will allow us to use all elements
# Declared in the module
println(SpecialFunctions.gamma(3))


# A module is not like a class as you cannot have different values in the module, unlike a class
# Here we will define and export a module

module MyModule
export func2
    a=42
    function func1(x)
        return x^2
    end

    function func2(x)
        return func1(x)+a
    end

end # end of module

#%%
using .MyModule
x=func2(3)
println("Func2 $x")
# x=func1(3)    #will raise an error as func1 was not exported from the module
# println("Func1 $x")
# I could call func1 in the following way
x=MyModule.func1(3)
println("func1 modified call $x")

# A way to write documentation is by using @doc raw, like so

@doc raw"""
    test_doc(x)

    returns same thing
    #Examples
    ```example area1
    example area 1
    result from example
    ```
"""
function test_doc(x)
    return x
    
end


#This doc method is quite cool, now if you type ?test_doc in REPL it will give the documentation and example. This is of course after import/using the module

# End of this doc, it is full enough