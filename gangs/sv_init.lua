SS.Gangs.List = {}

Citizen.CreateThread(function()
    exports.oxmysql:execute("SELECT * FROM Gangs", {}, function(gangtable)
        if gangtable then
            for k,v in pairs(gangtable) do
                SS.Gangs.List[v.id] = v
            end
        end
    end)
end)