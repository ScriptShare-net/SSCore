Citizen.CreateThread(function()
    exports.oxmysql:execute("SELECT * FROM Groups", {}, function(grouptable)
        if grouptable then
            for k,v in pairs(grouptable) do
                SS.Groups[v.Name] = v
            end
        end
    end)
end)