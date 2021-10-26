exports["SSCore"]:uiCreateCustom("Selector", "SSCore", "core/selector/ui/index.html")

SS.Selector = {}

local characters = {}
local camera
local characterNumber = 1
local next = next
local spawnNumber = 1

CreateThread(function()
	TriggerServerEvent("SS:Server:Initiate")
end)

local function loadSkin(skin, entity)
	exports["SSCore"].applyModel(PlayerPedId(), skin.model, entity) -- no idea why the second value is the first value
	exports["SSCore"].applySkin(PlayerPedId(), skin.skin, entity)
	exports["SSCore"].applyTattoos(PlayerPedId(), skin.tattoos, entity)
	exports["SSCore"].applyClothing(PlayerPedId(), skin.clothing, entity)
	exports["SSCore"].applyCosmetics(PlayerPedId(), skin.cosmetics, entity)
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
	local spawnMessage = "Create"
	local sexMessage = "Male"
	if characters[charID].firstName ~= "Create" then spawnMessage = "Spawn" end
	if characters[charID].skin.sex == 1 then sexMessage = "Female" end
	exports["SSCore"]:uiSendMessage("Selector", {
		show = true,
		name = characters[charID].firstName .. " " .. characters[charID].lastName,
		job = characters[charID].job.nameLabel .. " - " .. (characters[charID].job.gradeLabel or "N/A"),
		group = characters[charID].group.nameLabel .. " - " .. (characters[charID].group.gradeLabel or "N/A"),
		bank = characters[charID].bank or 0,
		dob = characters[charID].dob,
		sex = sexMessage,
		spawn = spawnMessage,
	})
end

local function loadFirstCharacter()
	characterNumber = characters.favourite
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
	print(charID)
	loadSkin(characters[charID].skin)
	loadPlayerData(charID)
end

local function firstSpawnPlayer()
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
	RequestCollisionAtCoord(spawn.x, spawn.y, spawn.z)
	SetEntityCoordsNoOffset(ped, spawn.x, spawn.y, spawn.z, false, false, false, true)
	NetworkResurrectLocalPlayer(spawn.x, spawn.y, spawn.z, spawn.w, true, true, false)
	ClearPedTasksImmediately(ped)
	RemoveAllPedWeapons(ped)
	ClearPlayerWantedLevel(ped)
end

RegisterNetEvent("SS:Client:Initiate", function(characterData)
	characters = characterData
	exports["SSCore"].uiDisableAll()
	SetNuiFocus(true, true)
	firstSpawnPlayer()
	loadFirstCharacter()
end)

local function spawnPlayer(spawn)
	local ped = PlayerPedId()
	RenderScriptCams(false, true, 500, true, true)
	SetCamActive(camera, false)
	SetCanAttackFriendly(ped, true, false)
	NetworkSetFriendlyFireOption(true)
	ClearPedTasks(ped)
	FreezeEntityPosition(ped, false)
	RequestCollisionAtCoord(spawn.x, spawn.y, spawn.z)
	SetEntityCoordsNoOffset(ped, spawn.x, spawn.y, spawn.z, false, false, false, true)
	SetEntityHeading(ped, spawn.w)
	ClearPedTasksImmediately(ped)
	RemoveAllPedWeapons(ped)
	ClearPlayerWantedLevel(ped)
end

exports["SSCore"]:uiRegisterCallback("Selector", "nextchar", function(data, cb)
	characterNumber = characterNumber + 1
	if characterNumber > characters.max then characterNumber = 1 end
	loadCharacter(characterNumber)
end)

exports["SSCore"]:uiRegisterCallback("Selector", "prevchar", function(data, cb)
	characterNumber = characterNumber - 1
	if characterNumber < 1 then characterNumber = characters.max end
	loadCharacter(characterNumber)
end)

exports["SSCore"]:uiRegisterCallback("Selector", "spawnsel", function(data, cb)
	if characters[characterNumber].firstName ~= "Create" then
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
	else
		exports["SSCore"]:uiSendMessage("Selector", {
			create = true,
		})
	end
end)

local function getSpawn(spawnID)
	local i = 1
	for k,v in pairs(SS.Spawns) do
		if i == spawnID then
			return k, v
		end
		i = i + 1
	end
end

exports["SSCore"]:uiRegisterCallback("Selector", "nextspawn", function(data, cb)
	spawnNumber = spawnNumber + 1
	if spawnNumber > #SS.Spawns + 1 then spawnNumber = 1 end
	local spawnName, coords = getSpawn(spawnNumber)
	exports["SSCore"]:uiSendMessage("Selector", {
		map = true,
		spawnname = spawnName,
		x = coords.x,
		y = coords.y,
		z = coords.z,
	})
	SetCamCoord(camera, coords.x, coords.y, coords.z + 1321 - coords.z)
	PointCamAtCoord(camera, coords.x, coords.y, coords.z)
end)

exports["SSCore"]:uiRegisterCallback("Selector", "prevspawn", function(data, cb)
	spawnNumber = spawnNumber - 1
	if spawnNumber < 1 then spawnNumber = 1 end
	local spawnName, coords = getSpawn(spawnNumber)
	exports["SSCore"]:uiSendMessage("Selector", {
		map = true,
		spawnname = spawnName,
		x = coords.x,
		y = coords.y,
		z = coords.z,
	})
	SetCamCoord(camera, coords.x, coords.y, coords.z + 1321 - coords.z)
	PointCamAtCoord(camera, coords.x, coords.y, coords.z)
end)

exports["SSCore"]:uiRegisterCallback("Selector", "confirmspawn", function(data, cb)
	TriggerServerEvent("SS:Server:CreatePlayer", characterNumber)
	spawnPlayer(SS.Spawns[data.spawn])
	exports["SSCore"]:uiSendMessage("Selector", {
		show = false,
	})
	SetNuiFocus(false, false)
end)

exports["SSCore"]:uiRegisterCallback("Selector", "identity", function(data, cb)
	TriggerServerEvent("SS:Server:RegisterIdentity", data, characterNumber)
	SetNuiFocus(false, false)
	exports["SSCore"]:uiSendMessage("Selector", {
		create = false,
	})
end)

local function loadCutScene()
	local ped = PlayerPedId()
	SetEntityInvincible(ped, true)
    RequestCutscene("mp_intro_concat", 8)
	StartCutsceneAtCoords(-1117.77783203125, -1557.6248779296875, 3.3819,0)
	FreezeEntityPosition(ped, true)
	SetEntityVisible(ped, false)
	SetEntityCoords(ped, -1166.3077392578, -1632.8835449218, 4.3590087890625)
    Wait(5000)
	i = 0
	local sceneped
    local femaleindex = (GetEntityIndexOfCutsceneEntity("MP_Female_Character", (GetHashKey("mp_m_freemode_01") or GetHashKey("mp_f_freemode_01"))))
	local maleindex = (GetEntityIndexOfCutsceneEntity("MP_Male_Character", (GetHashKey("mp_m_freemode_01") or GetHashKey("mp_f_freemode_01"))))
	skintable = characters[characterNumber].skin
	if skintable.skin.sex == 0 then
		SetEntityVisible(GetPedIndexFromEntityIndex(femaleindex), false)
		sceneped = GetPedIndexFromEntityIndex(maleindex)
	else
		SetEntityVisible(GetPedIndexFromEntityIndex(maleindex), false)
		sceneped = GetPedIndexFromEntityIndex(femaleindex)
	end
	loadSkin(skintable, sceneped)
    while i <= 9 do
        local item = (GetEntityIndexOfCutsceneEntity("MP_Plane_Passenger_" .. i, (GetHashKey("mp_m_freemode_01") or GetHashKey("mp_f_freemode_01"))))
        local otherped = GetPedIndexFromEntityIndex(item)
        if GetEntityModel(item) == GetHashKey("mp_f_freemode_01") then
			--female peds
			SS.TriggerServerCallback("SS:Server:GetRandomFemale", function(skin, cosmetics, clothing, tattoos)
				local femaletable = {}
				femaletable.skin = skin or exports["SSCore"].getDefaultSkin()
				femaletable.skin.sex = 1
				femaletable.cosmetics = cosmetics or exports["SSCore"].getDefaultCosmetics()
				femaletable.clothing = clothing or exports["SSCore"].getDefaultClothing(femaletable.skin.sex)
				femaletable.tattoos = tattoos or {}
				loadSkin(femaletable, otherped)
			end)
        else
            --male peds
			SS.TriggerServerCallback("SS:Server:GetRandomMale", function(skin, cosmetics, clothing, tattoos)
				local maletable = {}
				maletable.skin = skin or exports["SSCore"].getDefaultSkin()
				maletable.skin.sex = 0
				maletable.cosmetics = cosmetics or exports["SSCore"].getDefaultCosmetics()
				maletable.clothing = clothing or exports["SSCore"].getDefaultClothing(maletable.skin.sex)
				maletable.tattoos = tattoos or {}
				loadSkin(maletable, otherped)
			end)
        end
        i = i + 1
    end
    Wait(15500)
	SetEntityCoords(ped, -1632.1977539062, -2780.2680664062, 13.9296875)
    Wait(11300)
	DoScreenFadeOut(10)
    StopCutsceneImmediately()
	FreezeEntityPosition(ped, false)
	SetEntityVisible(ped, true)
	SetEntityCoords(ped, -1042.0747070312, -2744.8879394532, 21.343627929688)
	SetEntityInvincible(ped, false)
	Wait(500)
	RenderScriptCams(false, true, 500, true, true)
	SetCamActive(camera, false)
	DoScreenFadeIn(1000)
end

RegisterNetEvent("SS:Client:CreateSkin", function()
	-- put the skin menu on screen and callback to this function
	--exports["SSCore"]:skinEditor(true, function(newSkin)-- first val is first spawn, second is callback when saved
	--	characters[characterNumber].skin = newSkin
		loadCutScene()
	--end)
end)