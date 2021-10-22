SS.Group = {}

function SS.Group.Create(name, level)
    self.name = name 
    self.permission = level

    self.SetName = function(name)
        if name then 
            self.name = name 
        end
    end

    self.GetName = function()
        return self.name 
    end

    self.SetPermission = function(level)
        if type(level) == "number" then 
            self.permission = level
        end
    end

    self.GetPermission = function()
        return self.permission
    end

end