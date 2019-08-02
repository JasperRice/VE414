using Plots, PyPlot

############### <BEGIN> Plot position for each trip ###############
Plots.plot(GRANGER_ALL.X, GRANGER_ALL.Y,
    xlim=(0,107), ylim=(0,107),
    title=string("Granger's position for all trips"), seriestype=:scatter, marker=1)
PLOTPATH = "C:\\Users\\Jasper Rice\\Desktop\\VE414\\Project\\Plot\\Granger\\Granger"
Plots.savefig(string(PLOTPATH))

for i in 1 : size(GRANGER, 1)
    Plots.plot(GRANGER[i].X, GRANGER[i].Y,
        xlim=(0,107), ylim=(0,107),
        title=string("Granger's position in trip ", i), seriestype=:scatter, marker=1)
    PLOTPATH = "C:\\Users\\Jasper Rice\\Desktop\\VE414\\Project\\Plot\\Granger\\Granger"
    Plots.savefig(string(PLOTPATH, i))
end

for i in 1 : size(POTTER, 1)
    Plots.plot(POTTER[i].X, POTTER[i].Y,
        xlim=(0,107), ylim=(0,107),
        title=string("Potter's position in trip ", i), seriestype=:scatter, marker=1)
    PLOTPATH = "C:\\Users\\Jasper Rice\\Desktop\\VE414\\Project\\Plot\\Potter\\Potter"
    Plots.savefig(string(PLOTPATH, i))
end

for i in 1 : size(WEASLEY, 1)
    Plots.plot(WEASLEY[i].X, WEASLEY[i].Y,
        xlim=(0,107), ylim=(0,107),
        title=string("Weasley's position in trip ", i), seriestype=:scatter, marker=1)
    PLOTPATH = "C:\\Users\\Jasper Rice\\Desktop\\VE414\\Project\\Plot\\Weasley\\Weasley"
    Plots.savefig(string(PLOTPATH, i))
end
############### <END> Plot  position for each trip ###############

PyPlot.clf()
PyPlot.scatter(GRANGER[1].X, GRANGER[1].Y, s=3*pi^2*(GRANGER[1].Close > zeros(size(GRANGER, 1))), alpha=0.5)
PyPlot.xlim(0, 107)
PyPlot.ylim(0, 107)
PyPlot.savefig("C:\\Users\\Jasper Rice\\Desktop\\VE414\\Project\\plot.png")
