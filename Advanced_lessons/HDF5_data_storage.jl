using Pkg
Pkg.add("JLD")

using JLD

#JLD can basically save any variable format to the disk

#collect is a function which returns an array of all specified items
# in other words, collect transforms a range into an array
x = collect(-3:0.1:3)
y = collect(-3:0.1:3)

#here we compute a grid which contains all possible combinations of x and y
xx = reshape([xi for xi in x for yj in y], length(y), length(x))
yy = reshape([yj for xi in x for yj in y], length(y), length(x))

z = sin.(xx .+yy.^2)

#create a dict containing x,y,z
data_dict=Dict("x"=>x,"y"=>y,"z"=>z)

save("data_dict.jld",data_dict)
# Store the data_dict


#Now let's read the data

data_dict2 = load("data_dict.jld")

#Let's inspect it using plots
x2 = data_dict2["x"]
y2 = data_dict2["y"]
z2 = data_dict["z"]

using Plots
plotly()#recall this is the backend of choice for interactive plots

plot(x2,y2,z2,st=:surface,color=:ice)
savefig("data_dict2") #to save as html and vue using iframe method

##It is also possible to store structures in jld

struct Person
    height::Float64
    height::Float64
end

Bob= Person(1.84,74)

dict_new=Dict("bob" => bob)
save("bob.jld",dict_new)

#So here we save bob and we would load it the same way, with one exception
# if we load bob, we MUST declare Person beforehand, which kinda makes sense imo...
# we can still retrieve the data, so it's not a massive deal, but it's clearner to not have the warnings

