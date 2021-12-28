SS.Gangs.Create = function(id, name, owner)
    self = {}

    self.id = id
    self.name = name
    self.owner = owner

    self.GetName = function()
        return self.name
    end

    self.SetName = function(name)
        self.name = name
    end

    self.GetOwner = function()
        return self.owner
    end

    self.SetOwner = function(owner)
        self.owner = owner
    end

    SS.Gangs.List[self.id] = self
end