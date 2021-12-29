SS.Businesses.List = {}

Citizen.CreateThread(function()
    MySQL.query("SELECT * FROM Businesses", {}, function(businesstable)
        if businesstable then
            for k,v in pairs(businesstable) do
                SS.Businesses.List[v.Name] = v
            end
        end
    end)
end)