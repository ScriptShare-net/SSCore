SS.Characters.Create = function(identifiers, source, characterID)
    SS.Characters.List[source] = {}
    local self = {}

    self.permID = identifiers.PermID
    self.source = source
    self.identifier = identifiers.identifier
    self.identifiers = identifiers
    self.charID = characterID
    self.MetaData = {}

    -- Money --
    self.MetaData.accounts = {
        bank = 0,
        cash = 0,
        dirty = 0,
    }
    self.MetaData.crypto = {
        btc = 0,
        eth = 0,
    }

    self.MetaData.job = "unemployed" -- Job
    self.MetaData.grade = "unemployed" -- Job Grade

    self.FirstName = "Unknown" -- Firstname
    self.LastName = "Unknown" -- Last name
    self.MetaData.name = self.firstname .. " " .. self.lastname -- First + Lastname
    self.MetaData.pay = 0 -- Pay
    self.MetaData.coords = vector3(0,0,0) -- Player Coords
    self.MetaData.weight = 0 -- Player weight (how much they're holding)

    -- Medical
    -- Blood Type, addiction level, fingerprints, skills
    self.MetaData.bloodtype = "O-"
    self.MetaData.addictionlevel = 0 
    self.MetaData.fingerprint = "Unknown"
    self.MetaData.skills = {
        driving = 0, 
        running = 0, 
        shooting = 0,
        flying = 0
    }

    self.MetaData.skin = {
        eyes = "blue", 
        hair = "black", 
        chin = "normal"
    }

    self.MetaData.outfits = {}

    -- Bank Functions --
    self.GetBank = function()
        return self.MetaData.accounts.bank
    end

    self.SetBank = function(amount)
        if type(amount) == "number" then
            self.MetaData.accounts.bank = amount
        end
    end

    self.AddBank = function(amount)
        if amount > 0 then
            self.MetaData.accounts.bank = self.MetaData.accounts.bank + amount
        end
    end

    self.RemoveBank = function(amount)
        if amount > 0 then
            self.MetaData.accounts.bank = self.MetaData.accounts.bank - amount
        end
    end

    --Cash Functions --
    self.GetCash = function()
        return self.MetaData.accounts.cash
    end

    self.SetCash = function(amount)
        if type(amount) == "number" then
            self.MetaData.accounts.cash = amount
        end
    end

    self.AddCash = function(amount)
        if type(amount) == "number" then 
            if amount > 0 then
                self.MetaData.accounts.cash = self.MetaData.accounts.cash + amount
            else 
                return
            end
        end
    end

    self.RemoveCash = function(amount)
        if type(amount) == "number" then 
            if amount > 0 then
                self.MetaData.accounts.cash = self.MetaData.accounts.cash - amount
            else
                return
            end
        end
    end

    --Dirty Cash Functions --
    self.GetDirty = function()
        return self.MetaData.accounts.dirty
    end

    self.SetDirty = function(amount)
        if type(amount) == "number" then
            self.MetaData.accounts.dirty = amount
        end
    end

    self.AddDirty = function(amount)
        if amount > 0 then
            self.MetaData.accounts.dirty = self.MetaData.accounts.dirty + amount
        end
    end

    self.RemoveDirty = function(amount)
        if amount > 0 then
            self.MetaData.accounts.dirty = self.MetaData.accounts.dirty - amount
        end
    end

    --BTC Functions --
    self.GetBTC = function()
        return self.MetaData.crypto.btc
    end

    self.SetBTC = function(amount)
        if type(amount) == "number" then
            self.MetaData.crypto.btc = amount
        end
    end

    self.AddBTC = function(amount)
        if amount > 0 then
            self.MetaData.crypto.btc = self.MetaData.crypto.btc + amount
        end
    end

    self.RemoveBTC = function(amount)
        if amount > 0 then
            self.MetaData.crypto.btc = self.MetaData.crypto.btc - amount
        end
    end

    --ETH Functions --
    self.GetETH = function()
        return self.MetaData.crypto.eth
    end

    self.SetETH = function(amount)
        if type(amount) == "number" then
            self.MetaData.crypto.eth = amount
        end
    end

    self.AddETH = function(amount)
        if amount > 0 then
            self.MetaData.crypto.eth = self.MetaData.crypto.eth + amount
        end
    end

    self.RemoveETH = function(amount)
        if amount > 0 then
            self.MetaData.crypto.eth = self.MetaData.crypto.eth - amount
        end
    end
    -- Job Functions  --
    self.GetJob = function()
        return self.MetaData.job
    end

    self.SetJob = function(job)
        self.MetaData.job = job
        TriggerClientEvent("SSCore:Client:JobChange", self.source, self.MetaData.job)
    end

    self.GetGrade = function()
        return self.MetaData.grade
    end

    self.SetGrade = function(grade)
        self.MetaData.grade = str(grade)
    end

    -- Name Functions -- 
    self.GetName = function()
        return self.MetaData.name
    end

    self.GetFirstname = function()
        return self.FirstName
    end

    self.SetFirstname = function(firstname)
        self.FirstName = firstname
        self.MetaData.name = self.FirstName .. " " .. self.LastName
    end

    self.GetLastname = function()
        return self.LastName
    end

    self.SetLastname = function(lastname)
        self.LastName = lastname 
        self.MetaData.name = self.FirstName .. " " .. self.LastName
    end	

    -- Perm ID Functions --
    self.GetPermID = function()
        return self.permID
    end

    -- Weight Functions -- 
    self.GetWeight = function()
        return self.MetaData.weight 
    end

    -- Medical things
    self.GetBloodtype = function()
        return self.MetaData.bloodtype
    end

    self.SetBloodtype = function(blood)
        for index, bloodtypes in pairs(SS.Config.Bloodtypes) do
            if bloodtypes == blood then  
                self.MetaData.bloodtype = blood
            else
                return
            end 
        end
    end

    -- Addiction levels
    self.GetAddictionLevel = function()
        return self.MetaData.addictionlevel
    end

    self.SetAddictionLevel = function(level)
        if type(level) == "number" then 
            if level >= 0 then 
                self.MetaData.addictionlevel = level
            end
        end
    end

    self.AddAddictionLevel = function(level)
        if type(level) == "number" then 
            if level >= 0 then 
                self.MetaData.addictionlevel = self.MetaData.addictionlevel + level
            end	
        end
    end

    -- Fingerprints
    self.GetFingerprint = function()
        return self.MetaData.fingerprint
    end

    self.SetFingerprint = function(type)
        self.MetaData.fingerprint = str(type)
    end

    -- Skills
    self.AddDrivingSkill = function(amount)
        if type(amount) == "number" then 
            if amount > 0 then 
                self.MetaData.skills.driving = self.MetaData.skills.driving + amount
            end
        end
    end

    self.AddShootingSkill = function(amount)
        if type(amount) == "number" then 
            if amount > 0 then 
                self.MetaData.skills.shooting = self.MetaData.skills.shooting + amount
            end
        end
    end

    self.AddRunningSkill = function(amount)
        if type(amount) == "number" then 
            if amount > 0 then 
                self.MetaData.skills.running = self.MetaData.skills.running + amount
            end
        end
    end

    self.AddFlyingSkill = function(amount)
        if type(amount) == "number" then 
            if amount > 0 then 
                self.MetaData.skills.flying = self.MetaData.skills.flying + amount
            end
        end
    end

    self.RemoveDrivingSkill = function(amount)
        if type(amount) == "number" then 
            if amount > 0 then 
                self.MetaData.skills.driving = self.MetaData.skills.driving - amount
            end
        end
    end

    self.RemoveShootingSkill = function(amount)
        if type(amount) == "number" then 
            if amount > 0 then 
                self.MetaData.skills.shooting = self.MetaData.skills.shooting - amount
            end
        end
    end

    self.RemoveRunningSkill = function(amount)
        if type(amount) == "number" then 
            if amount > 0 then 
                self.MetaData.skills.running = self.MetaData.skills.running - amount
            end
        end
    end

    self.RemoveFlyingSkill = function(amount)
        if type(amount) == "number" then 
            if amount > 0 then 
                self.MetaData.skills.flying = self.MetaData.skills.flying - amount
            end
        end
    end

    -- Player clothing 
    self.GetOutfits = function()
        return self.MetaData.outfits
    end

    SS.Characters.List[source] = self
end