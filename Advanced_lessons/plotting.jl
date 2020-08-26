using Pkg
# Pkg.add("Plots")

using Plots

x= 1:0.01:10*pi
y=sin.(x)

plot(x,y,label="sin(x)")
plot!(xlab="x",ylab="f(x)")

#plot, well it plots
#the ! will modify the current plot with the additional parameters we inputter
#in terms of vs code, it will simply create a new plot with the added parameters
# one plot per plot call
y2=sin.(x).^2
plot!(x,y2,label="sin(x)^2",color=:red,line=:dash)

#now we scale x axis to be logarithmic
xaxis!(:log10)
plot!(legend=:bottomleft)
savefig("img_save_test.png")#Saves it in the folder

#different backends, there is gr(), which is the default
#gr is relatively new, so we might want other backends such as PyPlots or Plotly

#plotly is apparently quite good for interactive plots

plotly()
x=1:0.1:3*pi
y=1:0.1:3*pi

xx=reshape([xi for xi in x for yj in y], length(y), length(x))
yy=reshape([yj for xi in x for yj in y], length(y), length(x))
zz=sin.(xx).*cos.(yy)

#The above contains quite a few elements, so let's break it down
#The doc for reshape is:
#Create an array with the same data as the given array, but with different 
#dimensions. An implementation for a particular type of array may choose whether 
#the data is copied or shared.

# the . is broadcasting, in this case it applies the function (sin or cos) to each
# element of the tuple, in this case, array from reshape

plot3d(xx,yy,zz,label=:none,st=:surface)
plot!(xlab="x",ylab="y",zlab="sin(x)*cos(y)")
savefig("img2_3D_plot")

#NOTE: the two plotly plots apear as blank in vscode as it cannot show interactive plots
#To obtain the interactive plot we use the following code in a html file, from vscode we right click the html file an click open in browser
#in my case specifically I need to use other browsers and use mozilla since my default browser is brave
#<iframe width="100%" height="450px" frameborder="0" scrolling="no" src="img2_3D_plot.html"></iframe>

#To save the interactive plot as a png I need ORCA
Pkg.add("ORCA")
using ORCA

savefig("img2_with_ORCA.png")



#Let's move on to PyPlots

# using Pkg
Pkg.add("PyPlot")
# using Plots
pyplot()

x=0:0.1:2*pi
y=sin.(x).^2

plot(x, y, label="sin(x)^2")
savefig("img3_pyplot.png")


#PyPlot backend also allows use of LaTeX in the labels

Pkg.add("LaTeXStrings")
using LaTeXStrings

plot(x,y,label=L"$\sin(x)^2$")
savefig("img4_pyplot_with_latex.png")


#This concludes that lesson, pretty cool stuff