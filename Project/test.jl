using Pkg
Pkg.add("PyPlot")

using CSV
using DataFrames
using DataFramesMeta
using Query

using Distributions
using Plots
using PyPlot

function UniformCircle(X, Y, R = 3)
    θ = rand(Uniform(0, 2*pi))
    r = rand(Uniform(0, R))
    x = X + r * cos(θ)
    y = Y + r * sin(θ)
    return [x, y]
end

FilePath = "C:\\Users\\Jasper Rice\\Desktop\\VE414\\Project\\data_proj_414.csv"
DF = CSV.File(FilePath) |> DataFrame

POTTER = @from i in DF begin
    @where i.Potter == 1
    @select {i.X, i.Y, i.Trip, i.Close, i.Far}
    @collect DataFrame
end

WEASLEY = @from i in DF begin
    @where i.Weasley == 1
    @select {i.X, i.Y, i.Trip, i.Close, i.Far}
    @collect DataFrame
end

GRANGER = @from i in DF begin
    @where i.Granger == 1
    @select {i.X, i.Y, i.Trip, i.Close, i.Far}
    @collect DataFrame
end

Plots.plot(DF.X, DF.Y, DF.Close, xlim=(0,100), ylim=(0,100), zlim=(0,20), seriestype=:scatter, marker=1)
PlotPath = "C:\\Users\\Jasper Rice\\Desktop\\VE414\\Project\\Plot"
savefig(PlotPath)

# Gif = plot3d(1, xlim=(0, 100), ylim=(0,100), zlim=(0,20), title="Close Tayes Number", marker=2)
# @gif for i=1:size(DF,1)
#     push!(plt, DF.X, DF.Y, DF.Close)
# end every 1
