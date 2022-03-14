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

exports("GetUserFromIdentifier", function(identifier) -- Get user from identifier. This allows people to get the user info from the identifier. Also works when the user is offline
	if Users then -- check if there are any users on the server
		for src, user in pairs(Users) do -- iterate through each user in the server
			if user.Identifier == identifier then -- check if the user has the same identifier
				return Users[src] -- send the requester the user information
			end
		end
	else -- check offline users
		MySQL.query("SELECT * FROM Users WHERE Identifier = @identifier", { -- mysql query to get the user with the same identifier
			["@identifier"] = identifier, -- set the identifier of the user you want to get
		}, function(result) -- set the result to result
			if result[1] then -- check if we found a user
				
			end
		end)
	end
end)

RegisterNetEvent("SS:Server:ClientLoad", function()
	local src = source
	if not Users[source].Loaded then
		TriggerEvent("SS:Server:ClientLoaded", src)
		Users[source].Loaded = true
	end
end)