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

