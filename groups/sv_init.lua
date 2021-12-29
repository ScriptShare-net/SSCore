SS.Groups.List = {}

Citizen.CreateThread(function()
    MySQL.query("SELECT * FROM Groups", {}, function(grouptable)
        if grouptable then
            for k,v in pairs(grouptable) do
                SS.Groups.List[v.Name] = v
            end
        end
    end)
end)