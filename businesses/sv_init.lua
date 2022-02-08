local Businesses = {}

exports("CreateBusiness", function(name)
    self = {}

    self.Name = name

	self.MetaData = {}

    Businesses[self.Name] = self
end)

CreateThread(function()
    MySQL.query("SELECT * FROM Businesses", {}, function(businesstable)
        if businesstable then
            for k,v in pairs(businesstable) do
                Businesses[v.Name] = v
            end
        end
    end)
end)