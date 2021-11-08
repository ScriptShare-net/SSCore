RegisterNetEvent("SS:Client:CreateZone", function(coords)
	local coords = {x = coords.x, y = coords.y, z = coords.z, size = 0.5}
	exports["SSCore"]:blipsCreate(json.encode(coords), coords, {r = 255, g = 0, b = 0}, "", {}, function() end)
end)