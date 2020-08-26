# Got to type section of the tutorial

# Abstract types are anything that isn't float, int, or Uint
# So any other type, like number, real, integer, signed, unsigned, abstract float etc...

# To declare a type we use either struct or type
# Kinda looks like object oriented programming
abstract type Person
end

abstract type Musician <:Person
end


mutable struct Rockstar <: Musician
    name::String
    instrument::String
    bandName::String
    headbandColor::String
    instrumentsPlayed::Int
end

struct ClassicMusician <: Musician 
    name::String
    instrument::String
end

#Note that Rockstar is mutable and Classic musician is not

mutable struct Physicist <: Person
    name::String
    sleepHours::Float64
    favouriteLanguage::String
end

aure = Physicist("Aurelio",6,"Julia")

println(aure.name)
println(aure.sleepHours)
aure.sleepHours=8
println(aure.sleepHours)
# Note that we were able to change the value as it is mutable, now we try with immutable

aure_musician=ClassicMusician("Aurelio","Violin")

println(aure_musician.instrument)
# aure_musician.instrument="bloop" #This will raise an error



#Functions and types: mutable dispatch

function introduceMe(person::Person)    #note that the first person is a variable, the second is the type/struct
    println("Hello, my name is $(person.name)")
end

introduceMe(aure)



# When a type is applied like a constructor

mutable struct MyData
    x::Float64
    x2::Float64
    y::Float64
    z::Float64
    function MyData(x::Float64, y::Float64)
        x2=x^2
        z= sin(x2+y)
        new(x,x2,y,z)#overwrites the previous values
    end
end

println(MyData(2.0,3.0))    #return the values of x,x2,y,and z

#It may be advantageous to declare the typing of the constructor variables as parametric, which accept information at construction time

mutable struct MyData2{T<:Real}
	x::T
	x2::T
	y::T
	z::Float64
	function MyData2{T}(x::T, y::T) where {T<:Real}
		x2=x^2
		z = sin(x2+y)
		new(x, x2, y, z)
	end
end

println(MyData2{Float64}(2.0,3.0))
println(MyData2{Int}(2,3))

