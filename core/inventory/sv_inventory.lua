local inventory = {}

inventory[1] = {
	name = "Ground",

	stash = {
		width = 10,
		height = 20,
	},

	stashcontent = {
		{
			column = 1,
			row = 1,
			width = 2,
			height = 2,
			name = "Pistol",
			count = 1,
			container = "stash",
			image = "https://cdn.discordapp.com/attachments/634645008364077057/906706483100651580/ap-pistol-item.png",
			type = "pistol",
			data = {},
			rotated = false,
			rotatedimage = "https://cdn.discordapp.com/attachments/634645008364077057/906707560961302568/ap-pistol-rotated.png"
		},
	},

	contents = {
		{
			column = 1,
			row = 1,
			width = 4,
			height = 4,
			name = "Backpack",
			count = 1,
			container = "backpack",
			image = "",
			type = "backpack",
			data = {
				width = 5,
				height = 5,
				items = {

				}
			},
			rotated = false,
			rotatedimage = ""
		}
	},
}

SS.RegisterServerCallback("SS:Server:GetInventory", function(source, cb)
	
	local inv = inventory[source]
	cb(inv)
end)

local function findItem(source, name)
	local inv = inventory[source]
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
	local inv = inventory[source]
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
	local itemId, container = hasItem(src, data.name, data.row, data.column, data.container)
	if itemId then
		inventory[src][container][itemId].row = data.y
		inventory[src][container][itemId].column = data.x
		inventory[src][container][itemId].rotated = data.rotated
		inventory[src][container][itemId].container = data.newcontainer
		if container ~= "contents" and inContents(data.container) then
			inventory[src]["contents"][#inventory[src]["contents"] + 1] = inventory[src][container][itemId]
			inventory[src][container][itemId] = nil
		end
		TriggerClientEvent("SS:Client:UpdateInventory", src, inventory[src])
	end
end)