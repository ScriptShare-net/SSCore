SS.Users.Create = function(identifier)
    local self = {}

    self.Identifier = identifier

    SS.GetPlayerIdentifiers(identifier, function(identifiers)
        self.Identifiers = identifiers

        self.Name = GetPlayerName(self.Identifiers.Source)

        MySQL.query("SELECT * FROM Identifiers WHERE Identifier = @identifier", {
            ["@identifier"] = identifier
        }, function(result)
            if result then
                self.AllIdentifiers = result
            end

            SS.Users.List[self.Identifiers.Source] = self
        end)
    end)
	print("User Created:", identifier)
end