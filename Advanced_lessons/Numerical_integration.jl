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
println("blarg")