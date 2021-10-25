exports["SSCore"]:uiCreateCustom("Selector", "SSCore", "core/selector/ui/index.html")

SS.Selector = {}

local characters = {}
local camera
local characterNumber = 1
local next = next

CreateThread(function()
	print("initiate1")
	TriggerServerEvent("SS:Server:Initiate")
end)

local function loadSkin(skin)
	exports["SSCore"].applyModel(PlayerPedId(), skin.model) -- no idea why the second value is the first value
	exports["SSCore"].applySkin(PlayerPedId(), skin.skin)
	exports["SSCore"].applyTattoos(PlayerPedId(), skin.tattoos)
	exports["SSCore"].applyClothing(PlayerPedId(), skin.clothing)
	exports["SSCore"].applyCosmetics(PlayerPedId(), skin.cosmetics)
end

local function pedgoto(ped, x, y, z)
	FreezeEntityPosition(ped, false)
	TaskGoStraightToCoord(ped, x, y, z, 1.0, -1, 1, 0)
	while true do
		Wait(50)
		local coords = GetEntityCoords(ped, true)
		local dist = Vdist2(coords.x, coords.y, coords.z, x, y, z)
		if dist < 0.01 then
			ClearPedTasks(ped)
			ClearPedSecondaryTask(ped)
			break
		end
	end
end

local function turntohead(ped, heading, timeout)
	FreezeEntityPosition(ped, false)
	TaskAchieveHeading(ped, heading, timeout)
	Wait(timeout)
end

local function loadPlayerData(charID)
	exports["SSCore"]:uiSendMessage("Selector", {
		show = true,
		name = characters[charID].firstName .. " " .. characters[charID].lastName,
		job = characters[charID].job .. " - " .. (characters[charID].job_grade or "N/A"),
		secondaryjob = characters[charID].secondaryjob or "N/A" .. " - " .. (characters[charID].secondaryjob_grade or "N/A"),
		bank = characters[charID].bank or 0,
		dob = characters[charID].dob,
		sex = characters[charID].skin.sex,
		spawn = "Spawn",
	})
end

local function loadFirstCharacter()
	characterNumber = characters.favourite
	print("test")
	local player = PlayerPedId()
	DoScreenFadeOut(10)
	loadSkin(characters[characters.favourite].skin)
	Wait(500)
	SetEntityCoords(player, -78.07911682129, -836.62414550782, 221.9912109375)
	DoScreenFadeOut(10)
	while not IsScreenFadedOut() do
		Wait(10)
	end
	FreezeEntityPosition(player, true)
	if camera then
		SetCamCoord(camera, -83.121209411622, -834.6384765625, 222.3023109375)
	else
		camera = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", -83.121209411622, -834.6384765625, 222.3023109375, 300.00,0.00,0.00, 100.00, false, 0)
	end
	PointCamAtCoord(camera, -83.591209411622, -835.9384765625, 221.9912109375)
	SetCamActive(camera, true)
	RenderScriptCams(true, false, 1, true, true)
	DoScreenFadeIn(500)
	Wait(500)
	SetEntityCoords(player, -78.07911682129, -836.62414550782, 221.9912109375)
	pedgoto(player, -83.538459777832, -835.75384521484, 221.9912109375)
	turntohead(player, 340.15747070312, 1000)
	FreezeEntityPosition(player, true)
	exports["SSCore"].uiEnable("Selector")
	loadPlayerData(characters.favourite)
end

local function loadCharacter(charID)
	loadSkin(characters[charID].skin)
	loadPlayerData(charID)
end

local function spawnPlayer()
	print("spawn player")
	local pedModel = `mp_m_freemode_01`
	local ped = PlayerPedId()
	local spawn = vector4(-78.07911682129, -836.62414550782, 221.9912109375, 0.0)

	RequestModel(pedModel)

	while not HasModelLoaded(pedModel) do
		RequestModel(pedModel)
		Wait(0)
	end
	ShutdownLoadingScreen()
	ShutdownLoadingScreenNui()
	SetCanAttackFriendly(ped, true, false)
	NetworkSetFriendlyFireOption(true)
	SetPlayerModel(PlayerId(), pedModel)
	SetModelAsNoLongerNeeded(pedModel)
	print("test2")
	RequestCollisionAtCoord(spawn.x, spawn.y, spawn.z)
	SetEntityCoordsNoOffset(ped, spawn.x, spawn.y, spawn.z, false, false, false, true)
	NetworkResurrectLocalPlayer(spawn.x, spawn.y, spawn.z, spawn.w, true, true, false)
	ClearPedTasksImmediately(ped)
	RemoveAllPedWeapons(ped)
	ClearPlayerWantedLevel(ped)
end

RegisterNetEvent("SS:Client:Initiate", function(characterData)
	print("initiate")
	characters = characterData
	exports["SSCore"].uiDisableAll()
	SetNuiFocus(true, true)
	spawnPlayer()
	loadFirstCharacter()
end)


exports["SSCore"]:uiRegisterCallback("Selector", "nextchar", function(data, cb)
	characterNumber = characterNumber + 1
	if characterNumber > characters.max then characterNumber = 1 end
	loadCharacter(characterNumber)
end)

exports["SSCore"]:uiRegisterCallback("Selector", "prevchar", function(data, cb)
	characterNumber = characterNumber - 1
	if characterNumber > characters.max then characterNumber = characters.max end
	loadCharacter(characterNumber)
end)

exports["SSCore"]:uiRegisterCallback("Selector", "spawnsel", function(data, cb)
	print("spawnsel")
	spawn = vector3(-1045.1604003906, -2750.3999023438, 21.360473632812)
	SetCamCoord(camera, spawn.x, spawn.y, spawn.z + 1321 - spawn.z)
	PointCamAtCoord(camera, spawn.x, spawn.y, spawn.z)
	exports["SSCore"]:uiSendMessage("Selector", {
		map = true,
		spawnname = "Spawn",
		x = spawn.x,
		y = spawn.y,
		z = spawn.z,
	})
	SetCloudHatOpacity(0)
end)

exports["SSCore"]:uiRegisterCallback("Selector", "nextspawn", function(data, cb)
	
end)

exports["SSCore"]:uiRegisterCallback("Selector", "prevspawn", function(data, cb)
	
end)

exports["SSCore"]:uiRegisterCallback("Selector", "confirmspawn", function(data, cb)
	spawnpos = vector3(-1045.1604003906, -2750.3999023438, 21.360473632812)
	ped = PlayerPedId()
	FreezeEntityPosition(ped, false)
	ClearPedTasks(ped)
	SetEntityCoords(ped, spawnpos.x, spawnpos.y, spawnpos.z)
	RenderScriptCams(false, true, 500, true, true)
	SetCamActive(camera, false)
	exports["SSCore"]:uiSendMessage("Selector", {
		show = false,
	})
	SetNuiFocus(false, false)
end)

exports["SSCore"]:uiRegisterCallback("Selector", "identity", function(data, cb)
	
end)