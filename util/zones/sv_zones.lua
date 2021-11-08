local zoneCreated = false
local zones = {}
local zonePlayers = {}

SS.Players = SS.Players or {}

local function initiate()
	if not zoneCreated then return end
	print("initiated")
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

local function pointInPolygon( x, y, pnt)
	--[[ local vertices = pnt ]]
	local points = pnt
		
	--[[ for i=1, #vertices-1, 2 do
		points[#points+1] = { x=vertices[i], y=vertices[i+1] }
	end ]]

	local i, j = #points, #points
	local inside = false

	for i=1, #points do
		if ((points[i].y < y and points[j].y>=y or points[j].y< y and points[i].y>=y) and (points[i].x<=x or points[j].x<=x)) then
			if (points[i].x+(y-points[i].y)/(points[j].y-points[i].y)*(points[j].x-points[i].x)<x) then
				inside = not inside
			end
		end
		j = i
	end

	return inside
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
		return pointInPolygon(coords.x, coords.y, self.points)
		--[[ local x = coords.x
		local y = coords.y
		local z = coords.z

		if x < self.minX or x > self.maxX or y < self.minY or y > self.maxY then
			return false
		end

		if z < self.minZ or z > self.maxZ then
			return false
		end

		local oddNodes = false
		local j = #self.points
		local maxPoint = self.points[j]
		for i, point in pairs(self.points) do
			if (point.y < coords.y and maxPoint.y >= coords.y or maxPoint.y < coords.y and point.y >= coords.y) then
				if (point.x + (coords.y - point.y) / (maxPoint.y - point.y) * (maxPoint.x - point.x) < coords.x) then
					oddNodes = true
				end
			end
			j = i;
		end
		return oddNodes  ]]
	end

	zones[identifier] = self
end)

local newpoints = {}
local newminZ = -100
local newmaxZ = 100

RegisterCommand("newpoint", function(source, args)
	local coords = GetEntityCoords(GetPlayerPed(source))
	newpoints[#newpoints + 1] = coords
	if coords.z - 10 < newminZ then
		newminZ = coords.z - 10
	end

	if coords.z + 10 > newmaxZ then
		newmaxZ = coords.z + 10
	end
	print(json.encode(coords))
	TriggerClientEvent("SS:Client:CreateZone", source, coords)
end)

RegisterCommand("createzone", function()
	exports["SSCore"]:zoneCreate("testZone", newpoints, newminZ, newmaxZ, function()
		print("Entered Zone")
	end, function()
		print("Left Zone")
	end)
end)