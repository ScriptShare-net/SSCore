SS.Businesses.List = {}

Citizen.CreateThread(function()
    exports.oxmysql:execute("SELECT * FROM Businesses", {}, function(businesstable)
        if businesstable then
            for k,v in pairs(businesstable) do
                SS.Businesses.List[v.Name] = v
            end
        end
    end)
end)