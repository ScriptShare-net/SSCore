SS.Business = {}

function SS.Business.Create()
    self.onDuty = {}
    self.name = "Unknown Name"

    self.accounts = {
        stored = 0
    }

    self.employees = {}
    self.grades = {}

    self.GetName = function()
        return name
    end

    self.SetName = function(name)
        self.name = name
    end

    self.SetDuty = function(source)
        self.onDuty[#self.onDuty+1] = source
    end

    self.GetDuty = function()
        return self.onDuty
    end

    self.GetBusinessMoney = function()
        return self.accounts.stored
    end

    self.SetBusinessMoney = function(amount)
        if type(amount) == "number" then 
            self.accounts.stored = amount 
        end
    end

    self.AddBusinessMoney = function(amount)
        if amount > 0 then 
            self.accounts.stored = self.accounts.stored + amount
        end
    end

    self.RemoveBusinessMoeny = function(amount)
        if amount > 0 then 
            self.accounts.stored = self.accounts.stored - amount 
        end
    end

    self.AddEmployee = function(source, grade)
        if type(source) == "number" then
            for grades, label in pairs(self.grades) do  
                if grade == grades then
                    local player = SS.Player.GetPlayerFromSource(source)
                    player.SetJob(self.name)
                    player.SetGrade(grade)
                    self.employees[source] = grade
                end
            end
        end
    end
    
    self.RemoveEmployee = function(source)
        if type(source) == "number" then 
            local player = SS.Player.GetPlayerFromSource(source)
            player.SetJob("unemployed")
            player.SetGrade("unemployed")
            self.employees[source] = nil
        end
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