SS.Gangs.List = {}

Citizen.CreateThread(function()
    MySQL.query("SELECT * FROM Gangs", {}, function(gangtable)
        if gangtable then
            for k,v in pairs(gangtable) do
                SS.Gangs.List[v.Name] = v
            end
        end
    end)
end)