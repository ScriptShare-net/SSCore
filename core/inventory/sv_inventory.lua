local inventory = {}

SS.RegisterServerCallback("SS:Server:GetInventory", function(source, cb)
	local xPlayer = SS.GetPlayerFromSource(source)
	local inv = inventory[xPlayer.identifier]
	local coords = GetEntityCoords(GetPlayerPed(source))
	local zoneid = exports["SSCore"]:isCoordsInAnyZone(coords)
	if zoneid then
		local zone = exports["SSCore"]:getZoneFromID(zoneid)
		local zoneInv = zone.getInventory()
		local zoneName = zone.getName()
		local zoneSize = zone.getSize()
		cb(inv, zoneName, zoneInv, zoneSize)
	else
		inventory[xPlayer.identifier]
		cb(inv, "Ground", {}, { width = 10, height = 20 })
	end
end)

local function findItem(source, name)
	local xPlayer = SS.GetPlayerFromSource(source)
	local inv = inventory[xPlayer.identifier]
	for k,v in pairs(inv.contents) do
		if v.name == name then
			return v.column, v.row, v.container
		end
	end
	for k,v in pairs(inv.stashcontent) do
		if v.name == name then
			return v.column, v.row, v.container
		end
	end
	return false
end

local function hasItem(source, name, row, column, container)
	local xPlayer = SS.GetPlayerFromSource(source)
	local inv = inventory[xPlayer.identifier]
	for k,v in pairs(inv.contents) do
		if v.name == name and v.row == row and v.column == column and v.container == container then
			return k, "contents"
		end
	end
	for k,v in pairs(inv.stashcontent) do
		if v.name == name and v.row == row and v.column == column and v.container == container then
			return k, "stashcontent"
		end
	end
	return false
end

local function inContents(container)
	local containers = {
		"backpack-inside",
		"wallet",
		"helmet",
		"armor",
		"holset",
		"hat",
		"mask",
		"glasses",
		"ear",
		"jacket",
		"shirt",
		"pants",
		"shoes",
		"watch",
		"chain",
		"primary",
		"secondary",
		"pistol",
		"knife",
		"vest",
		"flpocket",
		"frpocket",
		"blpocket",
		"brpocket",
		"backpack",
	}

	for k,v in pairs(containers) do
		if v == container then
			return true
		end
	end

	return false
end

RegisterNetEvent("SS:Server:moveItem", function(data)
	local src = source
	local xPlayer = SS.GetPlayerFromSource(source)
	local itemId, container = hasItem(src, data.name, data.row, data.column, data.container)
	if itemId then
		inventory[xPlayer.identifier][container][itemId].row = data.y
		inventory[xPlayer.identifier][container][itemId].column = data.x
		inventory[xPlayer.identifier][container][itemId].rotated = data.rotated
		inventory[xPlayer.identifier][container][itemId].container = data.newcontainer
		if container ~= "contents" and inContents(data.container) then
			inventory[xPlayer.identifier]["contents"][#inventory[xPlayer.identifier]["contents"] + 1] = inventory[xPlayer.identifier][container][itemId]
			inventory[xPlayer.identifier][container][itemId] = nil
		end
		TriggerClientEvent("SS:Client:UpdateInventory", src, inventory[xPlayer.identifier])
	end
end)

RegisterNetEvent("SS:Server:PlayerLoaded", function(src, charid)
	local xPlayer = SS.GetPlayerFromSource(src)
	exports.oxmysql:execute("SELECT identifier FROM inventory WHERE identifier = @identifier AND characterSlot = @charid", {
		["@identifier"] = xPlayer.identifier,
		["@charid"] = charid
	}, function(inv)
		if json.encode(inv) == json.encode({}) then
			exports.oxmysql:execute("INSERT INTO inventory (identifier, characterSlot, items, accounts, weight) VALUES (@identifier, @characterSlot, @items, @accounts, @weight)", {
				["@identifier"] = xPlayer.identifier,
				["@characterSlot"] = xPlayer.charID,
				["@items"] = json.encode({}),
				["@accounts"] = json.encode({}),
				["@weight"] = 0,
			})
		end
	end)
	exports.oxmysql:execute("SELECT items FROM inventory WHERE identifier = @identifier AND characterSlot = @charid", {
		["@identifier"] = xPlayer.identifier,
		["@charid"] = charid
	}, function(inv)
		inventory[xPlayer.identifier] = json.decode(inv)
	end)
end)

CreateThread(function()
	while true do
		Wait(30000)
		for k,v in pairs(SS.Players) do
			local xPlayer = SS.GetPlayerFromSource(k)
			local inv = inventory[xPlayer.identifier]
			inv["stash"] = nil
			exports.oxmysql:execute("UPDATE inventory SET items = @items WHERE identifier = @identifier AND characterSlot = @charid", {
				["@identifier"] = xPlayer.identifier,
				["@charid"] = xPlayer.charID,
				["@items"] = json.encode(inv),
			})
		end
	end
end)