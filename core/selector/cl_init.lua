exports["SSCore"]:uiCreateCustom("Selector", "SSCore", "core/selector/ui/index.html")

SS.Selector = {}

local characters = {}
local camera

CreateThread(function()
	print("initiate1")
	TriggerServerEvent("ss:Server:Initiate")
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

local function loadFirstCharacter()
	SendNUIMessage({
		show = true,
		name = characters[characters.favourite].firstName .. " " .. characters[characters.favourite].lastName,
		job = characters[characters.favourite].job .. " - " .. (characters[characters.favourite].job_grade or "N/A"),
		secondaryjob = characters[characters.favourite].secondaryjob or "N/A" .. " - " .. (characters[characters.favourite].secondaryjob_grade or "N/A"),
		bank = characters[characters.favourite].bank or 0,
		dob = characters[characters.favourite].dob,
		sex = characters[characters.favourite].skin.sex,
		spawn = buttonword,
	})
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
end

local function spawnPlayer()
	print("spawn player")
	local pedModel = GetHashKey("mp_m_freemode_01")
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

RegisterNetEvent("ss:Client:Initiate", function(characterData)
	print("initiate")
	characters = characterData
	exports["SSCore"].uiDisableAll()
	SetNuiFocus(true, true)
	spawnPlayer()
	loadFirstCharacter()
end)