SS.Gangs.Create = function(name, owner)
    self = {}

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
end