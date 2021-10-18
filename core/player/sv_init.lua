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
		if amount > 0 then
			self.accounts.cash = self.accounts.cash + amount
		end
	end
	
	self.RemoveCash = function(amount)
		if amount > 0 then
			self.accounts.cash = self.accounts.cash - amount
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
end
