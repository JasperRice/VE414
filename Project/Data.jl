using CSV, DataFrames, DataFramesMeta, Query
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
