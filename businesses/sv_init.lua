local Businesses = {} -- our local businesses table that stores each businesess data

exports("CreateBusiness", function(name) -- Create business export. This allows addons to create their own businesses they need in order to handle the data for the job. Ie burgershot or pdm etc.
    if Businesses[name] then return end -- end the function if the business has the same name
	local self = {} -- temproary local self table to store our data in

    self.Name = name -- store the name of our business
	self.Owner = "" -- create the owner variable for later altering

	self.Members = {} -- create the member table so we can update the members later
	self.Ranks = {} -- create the ranks table so we can update the ranks later
	self.MetaData = {} -- create the metadata table for the business so we can store data inside of it later

	MySQL.query("INSERT INTO Businesses (Name, Owner, Members, Ranks, MetaData) VALUES(@name, @owner, @members, @ranks, @metadata)", { -- mysql query to create the business in the database
		["@name"] = self.Name, -- set the business name
		["@owner"] = self.Owner, -- set the business owner
		["@members"] = json.encode(self.Members), -- set the encoded business members
		["@ranks"] = json.encode(self.Ranks), -- set the encoded business ranks
		["@metadata"] = json.encode(self.MetaData), -- set the encoded business meta data
	}, function()
		Businesses[self.Name] = self -- create the business in the table and set the local self table as its contents
	end)
end)

exports("ChangeBusinessOwner", function(name, owner) -- Change business owner export. This allows addons to change the owner of a business for things like sales, initial setup etc.
	if Businesses[name] then -- check if our business exists
		Businesses[name].Owner = owner -- set the owner given to the owner fo the business
	end
end)

exports("AddBusinessRank", function(name, rankName, rankLabel, rankMetadata) -- Add business rank export. This allows addons to add new ranks to the business like ceo, trainiee etc.
	if Businesses[name] then -- check if the business exists
		if not Businesses[name].Ranks[rankName] then -- make sure no rank has the same name
			Businesses[name].Ranks[rankName] = { -- create a new rank into the ranks table
				Name = rankName, -- set the name of the rank
				Label = rankLabel, -- set the label of the rank
				MetaData = rankMetadata, -- set the metadata of the rank
			}
		end
	end
end)

exports("RemoveBusinessRank", function(businessName, rankName) -- Remove business rank export. This allows addons to remove a rank when needed
	if Businesses[businessName] then -- check if the business exists
		if Businesses[businessName].Ranks[rankName] then -- check if the rank exists
			Businesses[businessName].Ranks[rankName] = nil -- remove the rank from the table
		end
	end
end)

CreateThread(function() -- parallel function
    MySQL.query("SELECT * FROM Businesses", {}, function(businesstable) -- mysql query to get all the businesses and return the result as businesstable
        if businesstable then -- check if the businesstable has stuff in it
            for k,v in pairs(businesstable) do -- iterate through each business
                Businesses[v.Name] = v -- create the business in the table with our contents from mysql
            end
        end
    end)

	while true do -- run forever
		Wait(100) -- Pause for 100ms
		if Businesses ~= {} then -- check if we have any businesses
			for name, business in pairs(Businesses) do -- iterate through each business
				Wait(600000 / #Businesses) -- Pause for 10 minutes divided by how many businesses we have. Basically just splits all the data to reduce stress on resources
				MySQL.query("UPDATE Businesses SET Owner = @owner, Members = @members, Ranks = @ranks, MetaData = @metadata", { -- mysql query to update the owner, members, ranks and metadata of the business
					["@owner"] = business.Owner, -- set the business owner
					["@members"] = json.encode(business.Members), -- set the encoded business members
					["@ranks"] = json.encode(business.Ranks), -- set the encoded business ranks
					["@metadata"] = json.encode(business), -- set the encoded business meta data table
				})
			end
		end
	end
end)