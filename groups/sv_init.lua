local Groups = {}

exports("GetGroups", function()
	return Groups
end)

exports("GetGroupFromName", function(name)
	return Groups[Name]
end)

CreateThread(function()
    MySQL.query("SELECT * FROM Groups", {}, function(grouptable)
        if grouptable then
            for k,v in pairs(grouptable) do
                Groups[v.Name] = v
            end
        end
    end)
end)