# using Pkg
# Pkg.add("PyPlot")

using CSV, DataFrames, DataFramesMeta, Query
using Distances
using Distributions
using Plots
# using PyPlot

LOWER_BOUND = 0
UPPER_BOUND = 107

function UniformCircle(X, Y, R = 3)
    x = -1
    y = -1
    while (x-LOWER_BOUND)*(x-UPPER_BOUND)>0 || (y-LOWER_BOUND)*(y-UPPER_BOUND)>0
        θ = rand(Uniform(0, 2*pi))
        r = rand(Uniform(0, R))
        x = X + r * cos(θ)
        y = Y + r * sin(θ)
    end
    return [x, y]
end

function EuclideanDistance(X, Y)
    if size(X) == size(Y)
        Dist = 0
        if size(X,1) == 1
            for i = 1 : size(X, 2)
                Dist += (X[i] -Y[i])^2
            end
            return sqrt(Dist)
        else
            for i = 1 : size(X, 1)
                Dist += (X[i] -Y[i])^2
            end
            return sqrt(Dist)
        end
    else
        print("Wrong size of array when calculating Euclidean distance.")
        exit()
    end
end

function IsDifferentTree(X, Y, Threshold = 1)
    if EuclideanDistance(X, Y) > Threshold
        return true
    else
        return false
    end
end

############### <BEGIN> Data collection ###############
FILEPATH = "C:\\Users\\Jasper Rice\\Desktop\\VE414\\Project\\Data.csv"
DF = CSV.File(FILEPATH) |> DataFrame

POTTER_ALL = @from i in DF begin
    @where i.Potter == 1
    @select {i.X, i.Y, i.Trip, i.Close, i.Far}
    @collect DataFrame
end
POTTER = Array{DataFrame, 1}(undef, 45)
for n = 1 : size(POTTER, 1)
    POTTER[n] = @from i in POTTER_ALL begin
        @where i.Trip == n
        @select {i.X, i.Y, i.Close, i.Far}
        @collect DataFrame
    end
end

WEASLEY_ALL = @from i in DF begin
    @where i.Weasley == 1
    @select {i.X, i.Y, i.Trip, i.Close, i.Far}
    @collect DataFrame
end
WEASLEY = Array{DataFrame, 1}(undef, 47)
for n = 1 : size(WEASLEY, 1)
    WEASLEY[n] = @from i in WEASLEY_ALL begin
        @where i.Trip == n
        @select {i.X, i.Y, i.Close, i.Far}
        @collect DataFrame
    end
end

GRANGER_ALL = @from i in DF begin
    @where i.Granger == 1
    @select {i.X, i.Y, i.Trip, i.Close, i.Far}
    @collect DataFrame
end
GRANGER = Array{DataFrame, 1}(undef, 43)
for n = 1 : size(GRANGER, 1)
    GRANGER[n] = @from i in GRANGER_ALL begin
        @where i.Trip == n
        @select {i.X, i.Y, i.Close, i.Far}
        @collect DataFrame
    end
end
############### <END> Data collection ###############

Plots.plot(POTTER[1].X, POTTER[1].Y, POTTER[1].Close,
    xlim=(0,107), ylim=(0,107), zlim=(0,20),
    title="3D Plot", seriestype=:scatter, marker=1)
PLOTPATH = "C:\\Users\\Jasper Rice\\Desktop\\VE414\\Project\\PotterPlot"
Plots.savefig(PLOTPATH)

Plots.plot(DF.X, DF.Y, DF.Close,
    xlim=(0,107), ylim=(0,107), zlim=(0,20),
    title="3D Plot", seriestype=:scatter, marker=1)
PLOTPATH = "C:\\Users\\Jasper Rice\\Desktop\\VE414\\Project\\Plot"
Plots.savefig(PLOTPATH)

# GIF = @animate for i=1:120
#     Plots.plot(DF.X[i], DF.Y[i], DF.Close[i])
# end
# gif(GIF, "C:\\Users\\Jasper Rice\\Desktop\\VE414\\Project\\GIF.gif", fps=60)

# Gif = plot3d(1, xlim=(0, 100), ylim=(0,100), zlim=(0,20), title="Close Tayes Number", marker=2)
# @gif for i=1:100
#     push!(plt, DF.X, DF.Y, DF.Close)
# end every 1
