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

#Function profiling
#This part teaches us how to spot function bottlenecks in the execution of a function in order to know which parts are optimized
#@time and @btime give the overall time of execution, but will provide no indication as to what is slowing it down
#We will use Profile

function take_a_breath()
    sleep(22-1e-3)
    return
end

function test8()
    r=zeros(100,100)
    take_a_breath()
    for i in 1:100
        A=rand(100,100)
        r+=A
    end
    return r
end

using Profile
test8()
Profile.clear()
@profile test8()
Profile.print() #not very user friendly, the text is super cryptic, alternate solution is @profview
@profview test8()

#Since I am using vscode, the tool is different, I don't get a visualisation, but instead text with time
#apparently, I should give color/graphs, need to look into this further
#So I got the color on the graph, but it isn't very specific as to what is causing the issue
#color is by using the little flame on the right hand side
#Ideally it would say that take_a_breath function is slower

#OK so red color means that a function has to be resolved at run time
#still don't fully understand




#Moving on from profiling
#Using inbound function

#when using for loops we often create them to not have out of bounds error
#If we are sure that the loop will work well (and it always should) we can use
#@inbound to remove the boundary check.

using BenchmarkTools
arr1=zeros(10000)

function put1!(arr)
    for i in 1:length(arr)
        arr[i]=1.0
    end
end

function put1_inbounds!(arr)
    @inbounds for i in 1:length(arr)
        arr[i]=1.0
    end
end

@btime put1!(arr1)

@btime put1_inbounds!(arr1)




#Static arrays
#Basically, if the dimension of an array is static (never changing)
#we can use this to our advantage. Sadly in the field of genomics this is rarely the case due to filtering

#Gonna skip this one, it is essentially useless for my purposes.

#So matrices work somewhat differently in Julia than in python
#In pyhton matrices are row first, in julia they are column first

arr1 = zeros(100,200)

@btime for i in 1:100
    for j in 1:200
        arr1[i,j]=1
    end
end

@btime for j in 1:200
    for i in 1:100
        arr1[i,j]=1
    end
end




