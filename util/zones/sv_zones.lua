local zoneCreated = false
local zones = {}
local zonePlayers = {}

SS.Players = SS.Players or {}

local function initiate()
	if not zoneCreated then return end
	CreateThread(function()
		while zoneCreated do
			Wait(100)
			for src, _ in pairs(SS.Players) do
				local currentZone
				if not zonePlayers[src] then zonePlayers[src] = "none" end
				local coords = GetEntityCoords(GetPlayerPed(src))
				for id, zone in pairs(zones) do
					if zone.isInside(coords) then
						currentZone = id
					end
				end
				if not currentZone then
					if zonePlayers[src] ~= "none" then
						zones[zonePlayers[src]].leave(src)
					end
				else
					if currentZone ~= zonePlayers[src] then
						if zonePlayers[src] ~= "none" then
							zones[zonePlayers[src]].leave(src)
						end
						zones[currentZone].enter(src)
					end
				end
			end
		end
	end)
end

local function getLowestHighestZ(points)
	local lowest, highest
	for k,v in pairs(points) do
		if not lowest then lowest, highest = v.z, v.z
		if v.z < lowest then lowest = v.z end
		if v.z > highest then highest = v.z end
	end
	return lowest, highest
end

exports("zoneCreate", function(identifier, points, minZ, maxZ, enterCallback, leaveCallback)
	if not identifier then return end
	if not points then return end
	if not zoneCreated then
		zoneCreated = true
		initiate()
	end

	zones[identifier] = {}
	self = {}

	self.identifier = identifier
	self.points = points
	self.minZ = minZ or -100
	self.maxZ = maxZ or 100

	for _, coords in pairs(self.points) do
		if not self.minX and not self.minY then
			self.minX, self.minY = coords.x, coords.y
		end

		if not self.maxX and not self.maxY then
			self.maxX, self.maxY = coords.x, coords.y
		end

		if self.minX > coords.x then
			self.minX = coords.x
		end

		if self.maxX < coords.x then
			self.maxX = coords.x
		end

		if self.minY > coords.y then
			self.minY = coords.y
		end

		if self.maxY < coords.y then
			self.maxY = coords.y
		end
	end
	
	self.enter = function(src)
		zonePlayers[src] = self.identifier
		enterCallback()
	end

	self.leave = function(src)
		zonePlayers[src] = "none"
		leaveCallback()
	end

	self.isInside = function(coords)
		local x, y, points = coords.x, coords.y, self.points
		local i, j = #points, #points
		local inside = false

		for i = 1, #points do
			if (points[i].y < y and points[j].y > = y or points[j].y < y and points[i].y > = y) and (points[i].x < = x or points[j].x < = x) then
				if points[i].x + (y - points[i].y) / (points[j].y - points[i].y) * (points[j].x - points[i].x) < x then
					inside = not inside
				end
			end
			j = i
		end

		return inside
	end

	self.draw = {}

	self.SetDraw = function(src, value)
		self.draw[src] = value
		if value then
			TriggerClientEvent("SS:Client:DrawZone", src, self.identifier, self.points, self.maxZ - self.minZ)
		else
			TriggerClientEvent("SS:Client:HideZone", src, self.identifier)
		end
	end

	zones[identifier] = self
end)

local newPoints = {}
local height = 0

RegisterCommand("AddPoint", function(source)
	local coords = GetEntityCoords(GetPlayerPed(source))
	newPoints[#newPoints + 1] = coords
	TriggerClientEvent("SS:Client:AddZonePoint", source, coords)
end)

RegisterCommand("SetHeight", function(source, args)
	height = tonumber(args[1])
	TriggerClientEvent("SS:Client:SetHeight", source, height)
end)

RegisterCommand("CreateZone", function(source, args)
	local identifier = tostring(args[1])
	local minZ, maxZ = getLowestHighestZ(newPoints)
	exports["SSCore"]:zoneCreate(identifier, newPoints, minZ, maxZ + height, function()
		print("Entered Zone " .. identifier)
	end, function()
		print("Left Zone " .. identifier)
	end)
	print(" ------- Zone Created ------- ")
	print("Identifier: " .. identifier)
	print("Min Z: " .. minZ)
	print("Max Z: " .. maxZ)
	print("Height: " .. height)
	for k,v in pairs(newPoints) do
		print("Point " .. k .."- X: " .. v.x .. ", Y: " ..v.y .. ", Z: " .. v.z)
	end
	
	print(" ---------------------------- ")
	newPoints = {}
	height = 0
	TriggerClientEvent("SS:Client:FinishZone", source, identifier)
end)