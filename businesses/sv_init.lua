local Businessess = {}

exports("CreateBusiness", function(name)
    self = {}

    self.Name = name

    Businessess[self.Name] = self
end)

CreateThread(function()
    MySQL.query("SELECT * FROM Businesses", {}, function(businesstable)
        if businesstable then
            for k,v in pairs(businesstable) do
                Businessess[v.Name] = v
            end
        end
    end)
end)