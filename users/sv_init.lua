local SSCore = exports["SSCore"]

local Users = {}

exports("CreateUser", function(identifier, id)
    local self = {}

	self.Identifier = identifier
	self.Loaded = false

    SSCore:GetUserIdentifiers(id, function(identifiers)
        self.Identifiers = identifiers
		self.Identifiers.Source = #Users + 1

        self.Name = GetPlayerName(id)

        MySQL.query("SELECT * FROM Identifiers WHERE Identifier = @identifier", {
            ["@identifier"] = identifier
        }, function(result)
            if result then
                self.AllIdentifiers = result
            end

            Users[self.Identifiers.Source] = self
			TriggerEvent("SS:Server:PlayerConnected", self.Identifiers.Source)
			SSCore:Alert("User Created: " .. self.Identifiers.Source)
        end)
    end)
end)

exports("GetUsers", function()
	return Users
end)

exports("getUserFromSource", function(src)
	return Users[src]
end)

RegisterNetEvent("SS:Server:ClientLoad", function()
	local src = source
	if not Users[source].Loaded then
		TriggerEvent("SS:Server:ClientLoaded", src)
		Users[source].Loaded = true
	end
end)