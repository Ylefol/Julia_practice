#Entering some pretty heavy concepts here.

#Multithreading vs Multiprocessing
#Threads (my computer) are lightweight, threads use the same memory, meaning synchronisation of memory is important if multiple threads
#are accessing the same variable
#Julia has locks to prevent this, the downside of threading si that all threads are within the same machine

# Multiprocessing is used if we want to run it on a bunch of different machines, each process has it's own memory space
# Each process however consumes more memory than a threads

#Basically use threads if working with one machine and multiprocessing if working with several

##MULTI-THREADING

#So here it diverges from the tutorial, in VS code I need to go to the julia language settings and set the number of threads in a specific box
#I have 6 cores and each core is threaded twice, so I have 12 threads
# Restart of vscode was necessary after the change
println(Threads.nthreads())

using Pkg
Pkg.add("BenchmarkTools")
using BenchmarkTools
using SpecialFunctions


x=range(0,100, length=10000)
results=zeros(length(x))
@btime results .= besselj1.(x)
#This was without parallelization (I think)
#To achieve parallelization we use the Threads module
#So the Threads module is part of the base Julia, therefore we CAN'T call `using` or 'import' since it is always present

@btime Threads.@threads for i in 1:length(x)
    results[i]=besselj1(x[i])
end


#Composable Multithreading
#Allows us to start an operation on a specific thread, 
#with the spawn macro we can start several tasks simultaneously and fetch the results

#Also, from issues i've read, printing in @thread does not yet work in Julia, therefore the work around
#is to make the printing on a single thread.

function slow_func(x)
    sleep(0.005) #sleep for 5ms
    return x
end

@btime let
    a = Threads.@spawn slow_func(2)
    b = Threads.@spawn slow_func(4)
    c = Threads.@spawn slow_func(42)
    d = Threads.@spawn slow_func(12)
    res = fetch(a) .+ fetch(b) .* fetch(c) ./ fetch(d)
end
# speed is 5.365 ms (46 allocations: 3.64 kiB)

@btime let
    a = slow_func(2)
    b = slow_func(4)
    c = slow_func(42)
    d = slow_func(12)
    res = a .+ b .* c ./ d
end
# speed is 23.840 ms (20 allocations: 576 bytes)


#Carefull though, when working with samller functions, multi-threading is slower since the process of spawning new threads takes longer
#Than the calculation itself

#Ignoring multi-processing since I have no way of testing it out.





