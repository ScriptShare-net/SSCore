exports["SSCore"]:uiCreateCustom("Inventory", "SSCore", "core/inventory/ui/inventory.html")

local inventoryOpen = false
local hotbarOpen = false

--[[ contents = {
	column,
	row,
	width,
	height,
	name,
	count,
	container,
	image,
	type,
	data,
	rotated,
	rotatedimage
},
stashcontent = {
	column,
	row,
	width,
	height,
	name,
	count,
	container,
	image,
	type,
	data,
	rotated,
	rotatedimage
}, ]]

local function openInventory()
	local player = PlayerPedId()
	local inVehicle = IsPedInAnyVehicle(player, false)
	inventoryOpen = not inventoryOpen
	exports["SSCore"]:uiSetFocus("Inventory", inventoryOpen, inventoryOpen)
	exports["SSCore"]:uiSendMessage("Inventory", {
		show = inventoryOpen,
		name = "Ground",
		stash = {
			length = 4,
			width = 10,
			height = 50,
		},
	})
end

CreateThread(function()
	exports["SSCore"]:controlsRegister("tab", "Inventory", function()
		if not IsPlayerDead(PlayerPedId()) then
			openInventory()
		end
	end)
end)

exports("setHotbar", function(show)
	print(show)
	exports["SSCore"]:uiSendMessage("Inventory", {
		hotbar = show
	})
end)

exports("updateHotbar", function(data)
	exports["SSCore"]:uiSendMessage("Inventory", {
		hotbardata = data
	})
end)

exports["SSCore"]:uiRegisterCallback("Inventory", "closeInventory", function(data, cb)
	inventoryOpen = false
	exports["SSCore"]:uiSetFocus("Inventory", inventoryOpen, inventoryOpen)
end)