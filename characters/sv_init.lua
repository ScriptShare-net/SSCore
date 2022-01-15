local SSCore = exports["SSCore"]
local Characters = {}

exports("CreateCharacter", function(identifiers, source, characterID)
    Characters[source] = nil
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
	
    self.GetFirstName = function()
        return self.FirstName
    end
	
    self.SetFirstName = function(firstname)
        self.FirstName = firstname
        self.MetaData.name = self.FirstName .. " " .. self.LastName
    end
	
    self.GetLastName = function()
        return self.LastName
    end
	
    self.SetLastName = function(lastname)
        self.LastName = lastname 
        self.MetaData.name = self.FirstName .. " " .. self.LastName
    end	
	
    -- Perm ID Functions --
    self.GetPermID = function()
        return self.PermID
    end

    -- MetaData --
    self.GetMetaData = function(tblname)
        if tbl then
            return self.MetaData[tblname]
        else
            return self.MetaData
        end
    end

    self.SetMetaData = function(tblname, tblvalue)
        self.MetaData[tblname] = tblvalue
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
		Characters[source] = self
		SSCore:Alert("Created Character: "..source)
	end)
end)

exports("GetCharacters", function()
	return Characters
end)

exports("GetCharacterFromSource", function(source)
	return Characters[source]
end)

RegisterNetEvent("SS:Server:PlayerDisconnect", function(src)
	if Characters[src] then
		MySQL.query("UPDATE Characters SET MetaData = @metadata WHERE Identifier = @identifier", {
			["@identifier"] = Characters[src].Identifier,
			["@metadata"] = json.encode(Characters[src].MetaData)
		}, function(rows)
			Characters[src] = nil
			print("Updated Character: ",src)
		end)
	end
end)

RegisterNetEvent("onResourceStop", function()
	TriggerEvent("SS:Server:Stop")
	print("Update Characters")
	for k,v in pairs(Characters) do
		MySQL.query("UPDATE Characters SET MetaData = @metadata WHERE Identifier = @identifier", {
			["@identifier"] = v.Identifier,
			["@metadata"] = json.encode(v.MetaData)
		}, function(rows)
			Characters[k] = nil
		end)
	end
end)

CreateThread(function()
	while true do
		Wait(600000)
		print("Update Characters")
		for k,v in pairs(Characters) do
			MySQL.query("UPDATE Characters SET MetaData = @metadata WHERE Identifier = @identifier", {
				["@identifier"] = v.Identifier,
				["@metadata"] = json.encode(v.MetaData)
			}, function(rows)
			end)
		end
	end
end)