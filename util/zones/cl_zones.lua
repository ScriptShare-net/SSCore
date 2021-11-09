local zonePoints = {}
local draw = false
local zoneHeight = 0

local function initiate()
	if not draw then
		draw = true
		while draw do
			wait(1)
			local lastpoint
			for zone, points in pairs(zonePoints) do
				for k,v in pairs(points) do
					if not lastpoint then
						lastpoint = v
					else
						if height > 0 then
							DrawBox(lastpoint.x, lastpoint.y, lastpoint.z, v.x, v.y, v.z + height, 0, 255, 0, 100)
						else
							DrawLine(lastpoint.x, lastpoint.y, lastpoint.z, v.x, v.y, v.z, 0, 255, 0, 100)
						end
					end
				end
			end
		end
	end
end

RegisterNetEvent("SS:Client:AddZonePoint", function(coords)
	zonePoints["debug"][#points + 1] = coords
	if not draw then
		initiate()
	end
end)

RegisterNetEvent("SS:Client:SetHeight", function(height)
	height = height
end)

RegisterNetEvent("SS:Client:FinishZone", function(identifier)

	points = {}
	draw = false
	height = 0
end)

RegisterNetEvent("SS:Client:DrawZone", function(identifier, points, height)

end)

RegisterNetEvent("SS:Client:HideZone", function(identifier)
	
end)