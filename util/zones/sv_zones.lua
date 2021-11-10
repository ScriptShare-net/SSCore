local zoneCreated = false
local zones = {}
local circles = {}
local zonePlayers = {}

SS.Players = SS.Players or {}

exports("getZoneFromID", function(identifier)
	return zones[identifier] or circles[identifier]
end)

local function getInside(x, y, pnts)
	local i, j = #pnts, #pnts
	local inside = false

	for i = 1, #pnts do
		if (pnts[i].y < y and pnts[j].y >= y or pnts[j].y < y and pnts[i].y >= y) and (pnts[i].x <= x or pnts[j].x <= x) then
			if pnts[i].x + (y - pnts[i].y) / (pnts[j].y - pnts[i].y) * (pnts[j].x - pnts[i].x) < x then
				inside = not inside
			end
		end
		j = i
	end

	return inside
end

local function getZone(coords)
	local currentZone
	for id, zone in pairs(zones) do
		if getInside(coords.x, coords.y, exports["SSCore"]:getZoneFromID(id).points) then
			currentZone = id
		end
	end
	for id, circle in pairs(circles) do
		if #(coords - circle.center) <= circle.distance then
			currentZone = id
		end
	end
	return currentZone
end

exports("isCoordsInAnyZone", getZone)

local function initiate()
	if not zoneCreated then return end
	CreateThread(function()
		while zoneCreated do
			Wait(100)
			for src, _ in pairs(SS.Players) do
				if not zonePlayers[src] then zonePlayers[src] = "none" end
				local coords = GetEntityCoords(GetPlayerPed(src))
				local currentZone = getZone(coords)
				if not currentZone then
					if zonePlayers[src] ~= "none" then
						exports["SSCore"]:getZoneFromID(zonePlayers[src]).leave(src)
						zonePlayers[src] = "none"
					end
				else
					if currentZone ~= zonePlayers[src] then
						if zonePlayers[src] ~= "none" then
							exports["SSCore"]:getZoneFromID(zonePlayers[src]).leave(src)
							zonePlayers[src] = "none"
						end
						exports["SSCore"]:getZoneFromID(currentZone).enter(src)
						zonePlayers[src] = currentZone
					end
				end
			end
		end
	end)
end

local function getLowestHighestZ(points)
	local lowest, highest
	for k,v in pairs(points) do
		if not lowest then lowest, highest = v.z, v.z end
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

	self = {}

	self.identifier = identifier
	self.points = points
	self.minZ = minZ or -100
	self.maxZ = maxZ or 100
	self.name = identifier

	self.setName = function(name)
		self.name = name
	end

	self.getName = function()
		return self.name
	end

	self.inventory = {}

	self.getInventory = function()
		return self.inventory
	end

	self.setInventory = function(inv)
		self.inventory = inv
	end

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

	self.getIdentifier = function()
		return self.identifier
	end
	
	self.enter = function(src)
		enterCallback()
	end

	self.leave = function(src)
		leaveCallback()
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

exports("circleCreate", function(identifier, position, distance, height, enterCallback, leaveCallback)
	if not identifier then return end
	if not position then return end
	if not distance then return end
	if not zoneCreated then
		zoneCreated = true
		initiate()
	end

	self = {}

	self.identifier = identifier
	self.center = position
	self.distance = distance
	self.height = height
	self.inventory = {}

	self.getInventory = function()
		return self.inventory
	end

	self.setInventory = function(inv)
		self.inventory = inv
	end

	self.name = identifier

	self.setName = function(name)
		self.name = name
	end

	self.getName = function()
		return self.name
	end

	self.enter = function(src)
		enterCallback()
	end

	self.leave = function(src)
		leaveCallback()
	end

	self.width = 10

	self.height = 20

	self.setSize = function(width, height)
		self.width = width
		self.height = height
	end

	self.getSize = function()
		return self.width, self.height
	end

	circles[identifier] = self
end)

local newPoints = {}
local height = 0

RegisterCommand("AddPoint", function(source)
	local coords = GetEntityCoords(GetPlayerPed(source))
	coords = vector3(coords.x, coords.y, coords.z - 1)
	newPoints[#newPoints + 1] = coords
	TriggerClientEvent("SS:Client:AddZonePoint", source, coords)
end)

RegisterCommand("SetHeight", function(source, args)
	if not args[1] then return end
	height = tonumber(args[1])
	TriggerClientEvent("SS:Client:SetHeight", source, height)
end)

RegisterCommand("CreateZone", function(source, args)
	if not args[1] then return end
	local identifier = tostring(args[1])
	local minZ, maxZ = getLowestHighestZ(newPoints)
	exports["SSCore"]:zoneCreate(identifier, newPoints, minZ, maxZ + height, function()
		print("Entered Zone " .. identifier)
	end, function()
		print("Left Zone " .. identifier)
	end)
	TriggerClientEvent("SS:Client:FinishZone", source, identifier)
	TriggerClientEvent("SS:Client:DrawZone", source, identifier, newPoints, height)
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
end)

RegisterCommand("DrawZone", function(source, args)
	if not args[1] then return end
	local identifier = tostring(args[1])
	TriggerClientEvent("SS:Client:DrawZone", source, identifier, zones[identifier].points, zones[identifier].maxZ - zones[identifier].minZ)
end)

RegisterCommand("HideZone", function(source, args)
	if not args[1] then return end
	local identifier = tostring(args[1])
	TriggerClientEvent("SS:Client:HideZone", source, identifier)
end)

RegisterCommand("PrintZone", function(source)
	local coords = GetEntityCoords(GetPlayerPed(source))
	print(getZone(coords), zonePlayers[source])
end)

RegisterCommand("CreateCircle", function(source, args)
	local identifier = tostring(args[1])
	local distance = tonumber(args[2])
	local height = tonumber(args[3])
	local coords = GetEntityCoords(GetPlayerPed(source))

	exports["SSCore"]:circleCreate(identifier, coords, distance, height, function()
		print("Entered Zone " .. identifier)
	end, function()
		print("Left Zone " .. identifier)
	end)

	TriggerClientEvent("SS:Client:DrawCircle", identifier, coords, distance, height)
end)

RegisterCommand("HideCircle", function()
	TriggerClientEvent("SS:Client:HideCircle", identifier)
end)