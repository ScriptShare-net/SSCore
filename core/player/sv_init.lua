SS.Player = {}

function SS.Player.Create(permID, source)
	SS.Players[source] = {}
	local self = {}
	
	self.permID = permID
	self.source = source
	
	-- Money --
	self.accounts = {
		bank = 0,
		cash = 0,
		dirty = 0,
	}
	self.crypto = {
		btc = 0,
		eth = 0,
	}

	self.job = "unemployed" -- Job

	self.firstname = "Unknown" -- Firstname
	self.lastname = "Unknown" -- Last name
	self.name = self.firstname .. " " .. self.lastname -- First + Lastname
	self.pay = 0 -- Pay
	self.coords = vector3(0,0,0) -- Player Coords
	self.weight = 0 -- Player weight (how much they're holding)
	
	-- Bank Functions --
	self.GetBank = function()
		return self.accounts.bank
	end
	
	self.SetBank = function(amount)
		if type(amount) == "number" then
			self.accounts.bank = amount
		end
	end
	
	self.AddBank = function(amount)
		if amount > 0 then
			self.accounts.bank = self.accounts.bank + amount
		end
	end
	
	self.RemoveBank = function(amount)
		if amount > 0 then
			self.accounts.bank = self.accounts.bank - amount
		end
	end
	
	--Cash Functions --
	self.GetCash = function()
		return self.accounts.cash
	end
	
	self.SetCash = function(amount)
		if type(amount) == "number" then
			self.accounts.cash = amount
		end
	end
	
	self.AddCash = function(amount)
		if type(amount) == "number" then 
			if amount > 0 then
				self.accounts.cash = self.accounts.cash + amount
			else 
				return
			end
		end
	end
	
	self.RemoveCash = function(amount)
		if type(amount) == "number" then 
			if amount > 0 then
				self.accounts.cash = self.accounts.cash - amount
			else
				return
			end
		end
	end
	
	--Dirty Cash Functions --
	self.GetDirty = function()
		return self.accounts.dirty
	end
	
	self.SetDirty = function(amount)
		if type(amount) == "number" then
			self.accounts.dirty = amount
		end
	end
	
	self.AddDirty = function(amount)
		if amount > 0 then
			self.accounts.dirty = self.accounts.dirty + amount
		end
	end
	
	self.RemoveDirty = function(amount)
		if amount > 0 then
			self.accounts.dirty = self.accounts.dirty - amount
		end
	end
	
	--BTC Functions --
	self.GetBTC = function()
		return self.crypto.btc
	end
	
	self.SetBTC = function(amount)
		if type(amount) == "number" then
			self.crypto.btc = amount
		end
	end
	
	self.AddBTC = function(amount)
		if amount > 0 then
			self.crypto.btc = self.crypto.btc + amount
		end
	end
	
	self.RemoveBTC = function(amount)
		if amount > 0 then
			self.crypto.btc = self.crypto.btc - amount
		end
	end
	
	--ETH Functions --
	self.GetETH = function()
		return self.crypto.eth
	end
	
	self.SetETH = function(amount)
		if type(amount) == "number" then
			self.crypto.eth = amount
		end
	end
	
	self.AddETH = function(amount)
		if amount > 0 then
			self.crypto.eth = self.crypto.eth + amount
		end
	end
	
	self.RemoveETH = function(amount)
		if amount > 0 then
			self.crypto.eth = self.crypto.eth - amount
		end
	end

	self.GetJob = function()
		return self.job
	end

	self.SetJob = function(job)
		self.job = job
	end

	self.GetName = function()
		return self.name
	end

	self.GetFirstname = function()
		return self.firstname
	end

	self.SetFirstname = function(firstname)
		self.firstname = firstname
		self.name = self.firstname .. " " .. self.lastname
	end

	self.GetLastname = function()
		return self.lastname
	end

	self.SetLastname = function(lastname)
		self.lastname = lastname 
		self.name = self.firstname .. " " .. self.lastname
	end	

	self.GetWeight = function()
		return self.weight 
	end

	SS.Players[source] = self
end

function SS.Player.GetPlayerFromSource(source)
	local player = source
	if type(player) == 'number' then 
		return SS.Players[source]
	end
end

function SS.Player.GetPlayerFromId(id)
	local player = id

	for source, player in pairs(SS.Players) do
		if player.permID == id then  
			return player
		end
	end
end

function SS.Player.Save(source)
    local ped = GetPlayerPed(source)
	local plyCoords = GetEntityCoords(ped)
end

function SS.Player.GetAll()
	local players = {}

	for source, player in pairs(SS.Players) do 
		players[#players+1]
	end

	return players, #players
end

function SS.Player.SaveAll()
	local players = SS.Player.GetAll()

	for #players > 0 do 
		print("Stuff")
	end
end