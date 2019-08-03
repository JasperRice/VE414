using CSV
using DataFrames
using Query
FILEPATH = "C:\\Users\\Jasper Rice\\Desktop\\VE414\\Project\\Data.csv"
DF = CSV.File(FILEPATH) |> DataFrame


GRANGER_ALL = @from i in DF begin
    @where i.Granger == 1
    @select {i.X, i.Y, i.Trip, i.Close, i.Far}
    @collect DataFrame
end
GRANGER_CLOSE_ALL = @from i in GRANGER_ALL begin
    @where i.Close > 0
    @select {i.X, i.Y, i.Trip, i.Close, i.Far}
    @collect DataFrame
end
GRANGER = Array{DataFrame, 1}(undef, maximum(GRANGER_ALL.Trip))
for n = 1 : size(GRANGER, 1)
    GRANGER[n] = @from i in GRANGER_ALL begin
        @where i.Trip == n
        @select {i.X, i.Y, i.Close, i.Far}
        @collect DataFrame
    end
end
GRANGER_CLOSE = Array{DataFrame, 1}(undef, maximum(GRANGER_ALL.Trip))
for n = 1 : size(GRANGER_CLOSE, 1)
    GRANGER_CLOSE[n] = @from i in GRANGER[n] begin
        @where i.Close > 0
        @select {i.X, i.Y, i.Close, i.Far}
        @collect DataFrame
    end
end


POTTER_ALL = @from i in DF begin
    @where i.Potter == 1
    @select {i.X, i.Y, i.Trip, i.Close, i.Far}
    @collect DataFrame
end
POTTER_CLOSE_ALL = @from i in POTTER_ALL begin
    @where i.Close > 0
    @select {i.X, i.Y, i.Trip, i.Close, i.Far}
    @collect DataFrame
end
POTTER = Array{DataFrame, 1}(undef, maximum(POTTER_ALL.Trip))
for n = 1 : size(POTTER, 1)
    POTTER[n] = @from i in POTTER_ALL begin
        @where i.Trip == n
        @select {i.X, i.Y, i.Close, i.Far}
        @collect DataFrame
    end
end
POTTER_CLOSE = Array{DataFrame, 1}(undef, maximum(POTTER_ALL.Trip))
for n = 1 : size(POTTER_CLOSE, 1)
    POTTER_CLOSE[n] = @from i in POTTER[n] begin
        @where i.Close > 0
        @select {i.X, i.Y, i.Close, i.Far}
        @collect DataFrame
    end
end


WEASLEY_ALL = @from i in DF begin
    @where i.Weasley == 1
    @select {i.X, i.Y, i.Trip, i.Close, i.Far}
    @collect DataFrame
end
WEASLEY_CLOSE_ALL = @from i in WEASLEY_ALL begin
    @where i.Close > 0
    @select {i.X, i.Y, i.Trip, i.Close, i.Far}
    @collect DataFrame
end
WEASLEY = Array{DataFrame, 1}(undef, maximum(WEASLEY_ALL.Trip))
for n = 1 : size(WEASLEY, 1)
    WEASLEY[n] = @from i in WEASLEY_ALL begin
        @where i.Trip == n
        @select {i.X, i.Y, i.Close, i.Far}
        @collect DataFrame
    end
end
WEASLEY_CLOSE = Array{DataFrame, 1}(undef, maximum(WEASLEY_ALL.Trip))
for n = 1 : size(WEASLEY_CLOSE, 1)
    WEASLEY_CLOSE[n] = @from i in WEASLEY[n] begin
        @where i.Close > 0
        @select {i.X, i.Y, i.Close, i.Far}
        @collect DataFrame
    end
end
