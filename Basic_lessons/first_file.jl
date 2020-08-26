
#My first function in Julia
function my_first_function(message)
    return message
end

#Calls the function, very similar to python
my_first_function("blarg")


#create arrays
#convention dictates that an array or table should be initialized to zeros and then filled
table=zeros(2,3,4)
# print(table)

#Julia has print ln which will autoline skip. println is the equivalent of print in python
println("")
#The 2 is the number of rows, the 3 is the number of columns
#The 4 is the number of tables, or it can be seen as the number of matrices using the same rows and columns

#Seems that 'end' is always used to finish functions, loops, ifs etc...
for k in 1:4
    for j in 1:3
        for i in 1:2
            table[i,j,k] = i*j*k
        end
    end
end

# ctrl + ?/key is line comment

# print(table)

# learning slices
# slices is used to access subset of elements, same as python

a=[1,2,3,4,5]
b=a[2:5]

#Interestingly, indexes start at 1 and not at 0, that will take some getting used to
# println(a)
# println(b)

# Tuple time
# Tuples can be created with or without brackets

a=(1,2,3)
b=1,2,3

# They print the same thing
# println(a)
# println(b)


tuple1 = 1,2,3

#Essentially we can attribute each element of the tuple to individual variables, exceeding the number causes arror (ex:adding a d)
a,b=tuple1
# println(tuple1)
# println(a)

#I believe the dollar sign allows us to print the value of b as a string
# println("$b")
# println(c)

#And if we remove c, a and b are 1 and 2 respectively, the 3 of the tuple isn't assigned

# All in all tuples in Julia are essentially the same as in python


# something called splatting, it is sending a single variable (tuple) into a functions parameters
# this is allows us to give a function that requires three parameters a single variable
# pretty cool really
# for this to work, the tuple inputed into the function NEEDS a ... after the inputed parameter
function splat_me(a,b,c)
    return a*b*c
end

tuple1=5,6,8

splat_me(tuple1...)

# Named tuples
namedTuple1 = (a=1,b="hello")

println(namedTuple1)
println(namedTuple1[:a])

namedTuple2=NamedTuple{(:a,:b)}((2,"hello2"))
println(namedTuple2[:b])

# Above are the two methods to write named tuples, pretty straight forward really

#Moving on to dictionnary, the function is the same as python, but the nomenclature is different
# Accessing the elements of the dictionnary is the same, it's just the creation that changes
person1=Dict("Name"=>"Yohan","phone"=>"not gonna happen","shoe size"=>42)
print(person1["Name"])

#end of this file, moving on to the next




