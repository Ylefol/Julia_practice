module TestPackage1
using SpecialFunctions

export mySpecialFunction

    greet()=print("hello world!")

    function mySpecialFunction(x)
        return x^2 * gamma(x)
    end    
end