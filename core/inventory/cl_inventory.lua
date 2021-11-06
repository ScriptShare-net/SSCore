exports["SSCore"]:uiCreateCustom("Inventory", "SSCore", "core/inventory/ui/inventory.html")

local inventoryOpen = false

local function openInventory()
	local player = PlayerPedId()
	local inVehicle = IsPedInAnyVehicle(player, false)
	inventoryOpen = not inventoryOpen
	exports["SSCore"]:uiSetFocus("Inventory", inventoryOpen, inventoryOpen)
	exports["SSCore"]:uiSendMessage("Inventory", {
		show = inventoryOpen,
		menu = "Ground"
	})
end

CreateThread(function()
	exports["SSCore"]:controlsRegister("tab", "Inventory", function()
		if not IsPlayerDead(PlayerPedId()) then
			openInventory()
		end
	end)
end)