SS.Business = {}

function SS.Business.Create()
    self.onDuty = {}
    self.name = "Unknown Name"

    self.GetName = function()
        return name
    end

    self.SetName = function(name)
        self.name = name
    end

    self.SetDuty = function(source)
        self.onDuty[#self.onDuty+1] = source
    end

end

function SS.Business.GetPlayersOnDuty(job)
	local sources = {}

    for name, business in pairs(SS.Businesses) do
        if name == job then 
            return business.onDuty, #business.onDuty 
        end
    end 
end