local Gangs = {}

exports("CreateGang", function(name, owner)
    self = {}

    self.ID = id
    self.Name = name
    self.Owner = owner

    self.GetName = function()
        return self.Name
    end

    self.SetName = function(name)
        self.Name = name
    end

    self.GetOwner = function()
        return self.Owner
    end

    self.SetOwner = function(owner)
        self.Owner = owner
    end

	self.MetaData = {}

    Gangs[self.Name] = self
end)

exports("GetGangs", function()
	return Gangs
end)

exports("GetGangFromName", function(name)
	return Gangs[name]
end)

CreateThread(function()
    MySQL.query("SELECT * FROM Gangs", {}, function(gangtable)
        if gangtable then
            for k,v in pairs(gangtable) do
                Gangs[v.Name] = v
            end
        end
    end)
end)