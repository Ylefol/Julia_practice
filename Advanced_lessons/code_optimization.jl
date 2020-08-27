# Will be going over how to best optimize my code, love the idea

# Julia draws it's speed from type stability and not from type annotation
# Type annotation (not the julia way) is a way to tell what a function should expect
# Example of type annotation

function test1(x::Int)
    println("$x is an Int")
end

function test1(x::Float64)
    println("$x is a Float64")
end

function test1(x)
    println("$x is neither Int or Float64")
end

test1(1)
test1(1.0)
test1("string")

#So here we basically created a multiple dispatch, so same function three times but reacts differently based on input
#This is the proper way to do this, but type annotation should ONLY be used in type dispatch scenarios
#Julia is crazy good (like python) at determining what to do with any type, therefore it is best to leave it vague for functions
#This of course does not apply to structures if they are to be used as classes

#Moving on to type stability
#This means that the type of the returned value of a function must depend only on the type of the input of the function and not
#on the particular value it is given.

#Let's do an Example
function test3(x)
    if x>0
        return x
    else
        return 0
    end
end

test3(2) #returns 2 in Int format
test3(2.0) #returns 2.0 in Float64 format
test3(-1.0) #return 0 in Int format

#So what we are getting at here is that even if we input a float, an Int might be returned, which is problematic
#Basically, Julia can't seem to determine BEFOREHAND what the return value will be, which leads to slower code

#for our example, the solution is easy, change return 0 to return zero(x) which will return 0 in the format of x

function test4(x)
    if x>0
        return x
    else
        return zero(x)
    end
end

test4(-1.0) #returns 0.0 in Float64 format

#This solution is easy, but often the code is much more difficult, a macro exists to make our life easier, it is @code_warntype

#It will indicate if a returned value is unstable, and it will color the result in red if any type instability issue is found
#To try it out, call a function with the macro, we will compare test3 and test4

@code_warntype test3(-1.0)
"""Output
Variables
  #self#::Core.Compiler.Const(test3, false)
  x::Float64

Body::Union{Float64, Int64} #THIS ON IS NORMALLY IN RED
1 ─ %1 = (x > 0)::Bool
└──      goto #3 if not %1
2 ─      return x
3 ─      return 0
"""

@code_warntype test4(-1.0)
"""Output
Variables
  #self#::Core.Compiler.Const(test4, false)
  x::Float64

Body::Float64
1 ─ %1 = (x > 0)::Bool
└──      goto #3 if not %1
2 ─      return x
3 ─ %4 = Main.zero(x)::Core.Compiler.Const(0.0, false)
└──      return %4
"""


#Note the difference between the two outputs
#We can see that the output of test3 can be either Int or Float which is no bueno
#We also see that test4's output can only be Float, which is bueno

#Testimony of tutorial giver states that solving type instability can accelerate code *1000


#A common error that can occur is changing the type of a variable inside the function

function test5()
    r=0
    for i in 1:10
        r+=sin(i)
    end
    return r
end


@code_warntype test5()
#This reveals that r starts as an int and is converted to bool, it is marked in red like so
#r::Union{Float64, Int64}

#To solve this we would only have to state r as 0.0

