SS.Users.Create = function(identifier, id)
    local self = {}

	self.Identifier = identifier
	self.Loaded = false

    SS.GetPlayerIdentifiers(id, function(identifiers)
        self.Identifiers = identifiers
		self.Identifiers.Source = #SS.Users.List + 1

        self.Name = GetPlayerName(id)

        MySQL.query("SELECT * FROM Identifiers WHERE Identifier = @identifier", {
            ["@identifier"] = identifier
        }, function(result)
            if result then
                self.AllIdentifiers = result
            end

            SS.Users.List[self.Identifiers.Source] = self
			TriggerEvent("SS:Server:PlayerConnected", self.Identifiers.Source)
			SS.Alert("User Created: " .. self.Identifiers.Source)
        end)
    end)
end