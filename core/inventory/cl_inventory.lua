exports["SSCore"]:uiCreateCustom("Inventory", "SSCore", "core/inventory/ui/inventory.html")

local inventoryOpen = false
local hotbarOpen = false
local Inventory = {}

local function openInventory(inventory)
	Inventory = inventory
	local player = PlayerPedId()
	local inVehicle = IsPedInAnyVehicle(player, false)
	inventoryOpen = true
	exports["SSCore"]:uiSetFocus("Inventory", inventoryOpen, inventoryOpen)
	exports["SSCore"]:uiSendMessage("Inventory", {
		show = inventoryOpen,
		name = inventory.name,
		stash = inventory.stash,
		stashcontent = inventory.stashcontent,
		contents = inventory.contents
	})
end

local function closeInventory()
	print("close inv")
	local player = PlayerPedId()
	local inVehicle = IsPedInAnyVehicle(player, false)
	inventoryOpen = false
	exports["SSCore"]:uiSetFocus("Inventory", inventoryOpen, inventoryOpen)
	exports["SSCore"]:uiSendMessage("Inventory", {
		hide = not inventoryOpen
	})
end

CreateThread(function()
	exports["SSCore"]:controlsRegister("tab", "Inventory", function()
		if not IsPlayerDead(PlayerPedId()) then
			SS.TriggerServerCallback("SS:Server:GetInventory", function(inv)
				print("Trigger Get Inventory")
				openInventory(inv)
			end)
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

exports["SSCore"]:uiRegisterCallback("Inventory", "moveItem", function(data, cb)
	TriggerServerEvent("SS:Server:moveItem", data)
end)

RegisterNetEvent("SS:Client:UpdateInventory", function(data)
	if inventoryOpen then
		Inventory = data
		closeInventory()
		openInventory(data)
	end
end)