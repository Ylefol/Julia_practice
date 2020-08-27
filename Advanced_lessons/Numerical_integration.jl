using Pkg
Pkg.add("QuadGK")

using QuadGK

func1(x)=exp(-x^2)
res,err=quadgk(func1,-Inf, Inf)

println(abs(res-sqrt(pi))/sqrt(pi))

#quadgk is used to perform numerical integration, it's first argument is the function to be integrated, second and third are integration boundaries

res,err = quadgk(func1,-Inf,Inf,order=12)
println(abs(res-sqrt(pi))/sqrt(pi))
#The order parameter increases the integration order, basically need to increase it when it gets complex
#The default order is seven and often enough to deal with any issues

##Functions with multiple arguments

func2(x,y,z) = x + y^3 +sin(z)

x=5
z=3
arg(y) = func2(x,y,z)

res,err = let x=5; z=3
    arg(y) = func2(x,y,z)

    quadgk(arg,1,3)
end

func3(x,y)=x^2*exp(y)

function test_int(x, ymin, ymax)
    arg(y) = func3(x,y)
    return quadgk(arg, ymin, ymax)[1]
end

println(test_int(3,1,5))

## Mostly math stuff that I won't use