SS.Player = SS.Player or {}
SS.Players = {}

function SS.Player.Create(identifier, permID, source)
	SS.Players[source] = {}
	local self = {}
	
	self.permID = permID
	self.source = source
	self.identifier = identifier
	
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
	self.grade = "unemployed" -- Job Grade

	self.firstname = "Unknown" -- Firstname
	self.lastname = "Unknown" -- Last name
	self.name = self.firstname .. " " .. self.lastname -- First + Lastname
	self.pay = 0 -- Pay
	self.coords = vector3(0,0,0) -- Player Coords
	self.weight = 0 -- Player weight (how much they're holding)

	-- Medical
	-- Blood Type, addiction level, fingerprints, skills
	self.bloodtype = "O-"
	self.addictionlevel = 0 
	self.fingerprint = "Unknown"
	self.skills = {
		driving = 0, 
		running = 0, 
		shooting = 0,
		flying = 0
	}

	self.skin = {
		eyes = "blue", 
		hair = "black", 
		chin = "normal"
	}

	self.outfits = {}

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
	-- Job Functions  --
	self.GetJob = function()
		return self.job
	end

	self.SetJob = function(job)
		self.job = job
	end

	self.GetGrade = function()
		return self.grade
	end

	self.SetGrade = function(grade)
		self.grade = str(grade)
	end
	
	-- Name Functions -- 
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

	-- Perm ID Functions --
	self.GetPermID = function()
		return self.permID
	end

	-- Weight Functions -- 
	self.GetWeight = function()
		return self.weight 
	end

	-- Medical things
	self.GetBloodtype = function()
		return self.bloodtype
	end

	self.SetBloodtype = function(blood)
		for index, bloodtypes in pairs(SS.Player.Bloodtypes) do
			if bloodtypes == blood then  
				self.bloodtype = blood
			else
				return
			end 
		end
	end

	-- Addiction levels
	self.GetAddictionLevel = function()
		return self.addictionlevel
	end

	self.SetAddictionLevel = function(level)
		if type(level) == "number" then 
			if level >= 0 then 
				self.addictionlevel = level
			end
		end
	end

	self.AddAddictionLevel = function(level)
		if type(level) == "number" then 
			if level >= 0 then 
				self.addictionlevel = self.addictionlevel + level
			end	
		end
	end

	-- Fingerprints
	self.GetFingerprint = function()
		return self.fingerprint
	end

	self.SetFingerprint = function(type)
		self.fingerprint = str(type)
	end

	-- Skills
	self.AddDrivingSkill = function(amount)
		if type(amount) == "number" then 
			if amount > 0 then 
				self.skills.driving = self.skills.driving + amount
			end
		end
	end

	self.AddShootingSkill = function(amount)
		if type(amount) == "number" then 
			if amount > 0 then 
				self.skills.shooting = self.skills.shooting + amount
			end
		end
	end

	self.AddRunningSkill = function(amount)
		if type(amount) == "number" then 
			if amount > 0 then 
				self.skills.running = self.skills.running + amount
			end
		end
	end

	self.AddFlyingSkill = function(amount)
		if type(amount) == "number" then 
			if amount > 0 then 
				self.skills.flying = self.skills.flying + amount
			end
		end
	end

	self.RemoveDrivingSkill = function(amount)
		if type(amount) == "number" then 
			if amount > 0 then 
				self.skills.driving = self.skills.driving - amount
			end
		end
	end

	self.RemoveShootingSkill = function(amount)
		if type(amount) == "number" then 
			if amount > 0 then 
				self.skills.shooting = self.skills.shooting - amount
			end
		end
	end

	self.RemoveRunningSkill = function(amount)
		if type(amount) == "number" then 
			if amount > 0 then 
				self.skills.running = self.skills.running - amount
			end
		end
	end

	self.RemoveFlyingSkill = function(amount)
		if type(amount) == "number" then 
			if amount > 0 then 
				self.skills.flying = self.skills.flying - amount
			end
		end
	end

	-- Player clothing 
	self.GetOutfits = function()
		return self.outfits
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
		players[#players+1] = source
	end

	return players, #players
end

function SS.Player.SaveAll()
	local players = SS.Player.GetAll()

	for src = 1, #players do 
		SS.Player.Save(src)
	end
end