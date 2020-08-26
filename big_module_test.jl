
#Critical information
"""
Apparently it is critical for performance to use concrete types inside a composite, such as Float64 in Real 
This also means that parametric type are good options to maintain type flexibility while also defining all the types of the variables inside a composite
"""

# Mutable types are particularly usefulk when it comes to storing data that needs to be shared between some functions inside a module. It is not uncommon to
# define custom types in a module to store all the data which needs to be shared between functions and which is not constant.

module TestModuleTypes
export Circle, computePerimeter, computeArea, printCircleEquation

	mutable struct Circle{T<:Real}
		radius::T
		perimeter::Float64
		area::Float64

		function Circle{T}(radius::T)where T<:Real
			# We initialize perimeter and area to -1.0, which is not a possible value
			new(radius,-1.0,-1.0)
		end
	end
	@doc raw"""
			computePerimeter(circle::Circle)
		
		compute the perimeter of `circle` and store the value
	"""
	function computePerimeter(circle::Circle)
		circle.perimeter=2*pi*circle.radius
		return circle.perimeter
	end

	@doc raw"""
			computeArea(circle::Cicle)

		compute the area of `circle` and store the value
	"""
	function computeArea(circle::Circle)
		circle.area=pi*circle.radius^2
		return circle.area
	end

	@doc raw"""
			printCircleEquation(xc::Real, yc::Real, circle::Circle)

		Print the equation of a circle with center at (xc,yc) and radius given by circle
	"""
	function printCircleEquation(xc::Real, yc::Real,circle::Circle)
		println("(x - $xc)^2 + (y - $yc)^2 = $(circle.radius^2)")
		return
	end
end

using .TestModuleTypes
#create the object, give it 5.0 as radius
circle1=Circle{Float64}(5.0)

#call the function from the module, it already has access to radius as it is within the module, it will then update the perimiter variable
computePerimeter(circle1)
println(circle1.perimeter)

#same thing as perimeter but for the area
computeArea(circle1)
println(circle1.area)

#Will print equation using 2 as xc and 3 as yc, being the x,y coordinates of the center point
printCircleEquation(2,3,circle1)

#This finalizes basic lessons, moving on to advanced.