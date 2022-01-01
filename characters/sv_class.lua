SS.Characters.Create = function(identifiers, source, characterID)
    SS.Characters.List[source] = {}
    local self = {}

	

    self.PermID = identifiers.PermID
    self.Source = source
    self.Identifier = identifiers.Identifier
    self.Identifiers = identifiers
    self.CharID = characterID
	self.FirstName = ""
	self.LastName = ""
    self.MetaData = {}
	self.MetaData.name = self.FirstName .. " " .. self.LastName

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
        return self.PermID
    end
	
	MySQL.query("SELECT * FROM Characters WHERE Identifier = @identifier AND CharacterSlot = @charslot", {
		["@identifier"] = self.Identifier,
		["@charslot"] = self.CharID,
	}, function(result)
		if result[1] then
			self.FirstName = result[1].FirstName
			self.LastName = result[1].LastName
			self.MetaData = json.decode(result[1].MetaData)
			self.MetaData.name = self.FirstName .. " " .. self.LastName
		end
		SS.Characters.List[source] = self
		SS.Alert("Created Character: "..source)
	end)
end