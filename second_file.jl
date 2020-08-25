
# if and else work the same as in python, they don't require a : and need an end, also it's elseif and not elif

function test_conditionals(x)
    if x==0
        println("it is zero")
    elseif x==1
        println("blarg")
    else
        println("else")
    end
end

test_conditionals(0)
test_conditionals(1)
test_conditionals(5)


function test_cond_2(x)
    println(x)
    if x>=1 & x<2
        println("bloop")
    end
end
#can't compare float, yup, not sure why
# seems that the function is somehow designed to only take in int
#i'll try to figure this out later
test_cond_2(1)

# Also, I was right, the $ is string interpolation, basically call the vlaue of whatever it is infront
# Will help with messages

# Example of for loop and string interpolation
# break works the same way as in python

# for i in 1:10
#     println("i = $i")
# end

#while loops are as expected

#enumerate works a bit differently though
x=["blarg","honk","bloop","beep","toto"]

for enum in enumerate(x)
    println(typeof(enum))
    println(enum[1])
    println(enum[2])
end

#basically enum is a tuple, and we have to splice it to access the index (1) and value (2)
#testing a la python
# it can work using parenthesis

for (idx,val) in enumerate(x)
    println(idx)
    println(val)
end




