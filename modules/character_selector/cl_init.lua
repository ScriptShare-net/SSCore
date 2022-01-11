local UIWrapper = exports["ui-wrapper"]
local SSCore = exports["SSCore"]

if SSCore:GetConfigValue("CharacterSelector") then
	SSCore:Alert("Loading Selector Module")
	UIWrapper:uiCreateCustom("CharacterSelector", "SSCore", "modules/character_selector/index.html")

	local characters = {}
	local camera
	local characterNumber = 1
	local next = next
	local spawnNumber = 1

	local function loadSkin(skin, entity)
		if SSCore:GetConfigValue("Skin") then
			SSCore:LoadSkin(skin, entity)
		end
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

	local function spawnAmount()
		local length = 0
		for k,v in pairs(SSCore:GetConfigValue("CharacterSelectorSpawns")) do
			length = length + 1
		end
		return length
	end

	local function getSpawn(spawnID)
		local i = 1
		for k,v in pairs(SSCore:GetConfigValue("CharacterSelectorSpawns")) do
			if i == spawnID then
				return k, v
			end
			i = i + 1
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
		if characters[charID].FirstName ~= "Create" then spawnMessage = "Spawn" end
		if characters[charID].Skin.sex == 1 then sexMessage = "Female" end
		UIWrapper:uiSendMessage("CharacterSelector", {
			show = true,
			name = characters[charID].FirstName .. " " .. characters[charID].LastName,
			job = characters[charID].Job.NameLabel .. " - " .. (characters[charID].Job.GradeLabel or "N/A"),
			gang = characters[charID].Gang.NameLabel .. " - " .. (characters[charID].Gang.GradeLabel or "N/A"),
			bank = characters[charID].Bank or 0,
			dob = characters[charID].DOB,
			sex = sexMessage,
			spawn = spawnMessage,
		})
	end

	local function loadFirstCharacter()
		characterNumber = characters.Favourite
		local player = PlayerPedId()
		DoScreenFadeOut(10)
		loadSkin(characters[characters.Favourite].Skin)
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
		UIWrapper:uiEnable("CharacterSelector")
		loadPlayerData(characters.Favourite)
	end

	local function loadCharacter(charID)
		loadSkin(characters[charID].Skin)
		loadPlayerData(charID)
	end

	local function firstSpawnPlayer()
		local pedModel = `mp_m_freemode_01`
		local ped = PlayerPedId()
		local spawn = vector4(-78.07911682129, -836.62414550782, 221.9912109375, 0.0)
		ShutdownLoadingScreen()
		ShutdownLoadingScreenNui()
		SetCanAttackFriendly(ped, true, false)
		NetworkSetFriendlyFireOption(true)
		SSCore:ApplyModel(pedModel)
		RequestCollisionAtCoord(spawn.x, spawn.y, spawn.z)
		SetEntityCoordsNoOffset(ped, spawn.x, spawn.y, spawn.z, false, false, false, true)
		NetworkResurrectLocalPlayer(spawn.x, spawn.y, spawn.z, spawn.w, true, true, false)
		ClearPedTasksImmediately(ped)
		RemoveAllPedWeapons(ped)
		ClearPlayerWantedLevel(ped)
	end

	RegisterNetEvent("SS:Client:Initiate", function(characterData)
		characters = characterData
		Wait(2000)
		UIWrapper:uiDisableAll()
		UIWrapper:uiSetFocus("CharacterSelector", true, true)
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
		UIWrapper:uiEnableAll()
	end

	UIWrapper:uiRegisterCallback("CharacterSelector", "nextchar", function(data, cb)
		characterNumber = characterNumber + 1
		if characterNumber > characters.Max then characterNumber = 1 end
		loadCharacter(characterNumber)
	end)

	UIWrapper:uiRegisterCallback("CharacterSelector", "prevchar", function(data, cb)
		characterNumber = characterNumber - 1
		if characterNumber < 1 then characterNumber = characters.Max end
		loadCharacter(characterNumber)
	end)

	UIWrapper:uiRegisterCallback("CharacterSelector", "spawnsel", function(data, cb)
		if characters[characterNumber].FirstName ~= "Create" then
			local spawnName, coords = getSpawn(spawnNumber)
			SetCamCoord(camera, coords.x, coords.y, coords.z + 1321 - coords.z)
			PointCamAtCoord(camera, coords.x, coords.y, coords.z)
			UIWrapper:uiSendMessage("CharacterSelector", {
				map = true,
				spawnname = spawnName,
				x = coords.x,
				y = coords.y,
				z = coords.z,
			})
			SetWeatherTypeNow("CLEAR")
			SetCloudHatOpacity(0)
		else
			UIWrapper:uiSendMessage("CharacterSelector", {
				create = true,
			})
		end
	end)

	UIWrapper:uiRegisterCallback("CharacterSelector", "nextspawn", function(data, cb)
		spawnNumber = spawnNumber + 1
		if spawnNumber > spawnAmount() then spawnNumber = 1 end
		local spawnName, coords = getSpawn(spawnNumber)
		UIWrapper:uiSendMessage("CharacterSelector", {
			map = true,
			spawnname = spawnName,
			x = coords.x,
			y = coords.y,
			z = coords.z,
		})
		SetCamCoord(camera, coords.x, coords.y, coords.z + 1321 - coords.z)
		PointCamAtCoord(camera, coords.x, coords.y, coords.z)
	end)

	UIWrapper:uiRegisterCallback("CharacterSelector", "prevspawn", function(data, cb)
		spawnNumber = spawnNumber - 1
		if spawnNumber < 1 then spawnNumber = spawnAmount() end
		local spawnName, coords = getSpawn(spawnNumber)
		UIWrapper:uiSendMessage("CharacterSelector", {
			map = true,
			spawnname = spawnName,
			x = coords.x,
			y = coords.y,
			z = coords.z,
		})
		SetCamCoord(camera, coords.x, coords.y, coords.z + 1321 - coords.z)
		PointCamAtCoord(camera, coords.x, coords.y, coords.z)
	end)

	UIWrapper:uiRegisterCallback("CharacterSelector", "confirmspawn", function(data, cb)
		TriggerServerEvent("SS:Server:CreatePlayer", characterNumber)
		spawnPlayer(SSCore:GetConfigValue("CharacterSelectorSpawns")[data.spawn])
		UIWrapper:uiSendMessage("CharacterSelector", {
			show = false,
		})
		UIWrapper:uiSetFocus("CharacterSelector", false, false)
	end)

	UIWrapper:uiRegisterCallback("CharacterSelector", "identity", function(data, cb)
		TriggerServerEvent("SS:Server:RegisterIdentity", data, characterNumber)
		UIWrapper:uiSetFocus("CharacterSelector", false, false)
		UIWrapper:uiSendMessage("CharacterSelector", {
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
		skintable = characters[characterNumber].Skin
		if skintable.sex == 0 then
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
				SSCore:TriggerServerCallback("SS:Server:GetRandomFemale", function(skin, cosmetics, clothing, tattoos)
					local femaletable = {}
					femaletable.skin = skin or SSCore:GetDefaultSkin()
					femaletable.model = "mp_f_freemode_01"
					femaletable.sex = 1
					femaletable.cosmetics = cosmetics or SSCore:GetDefaultCosmetics()
					femaletable.clothing = clothing or SSCore:GetDefaultClothing(femaletable.sex)
					femaletable.tattoos = tattoos or {}
					loadSkin(femaletable, otherped)
				end)
			else
				--male peds
				SSCore:TriggerServerCallback("SS:Server:GetRandomMale", function(skin, cosmetics, clothing, tattoos)
					local maletable = {}
					maletable.skin = skin or SSCore:GetDefaultSkin()
					maletable.model = "mp_m_freemode_01"
					maletable.sex = 0
					maletable.cosmetics = cosmetics or SSCore:GetDefaultCosmetics()
					maletable.clothing = clothing or SSCore:GetDefaultClothing(maletable.sex)
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
		UIWrapper:uiEnableAll()
		TriggerServerEvent("SS:Server:SpawningPlayer")
	end

	RegisterNetEvent("SS:Client:CreateSkin", function()
		local config = {
			ped = true,
			headBlend = true,
			faceFeatures = true,
			headOverlays = true,
			components = true,
			props = true,
		}
		
		exports['fivem-appearance']:startPlayerCustomization(function(appearance)
			if (appearance) then
				characters[characterNumber].Skin = SSCore:GetSkin()
				TriggerServerEvent("SS:Server:SetSkin", SSCore:GetSkin())
				loadCutScene()
			else
				Wait(10)
				TriggerEvent("SS:Client:CreateSkin")
			end
		end, config)
	end)
end

RegisterCommand('customization', function()
	local config = {
		ped = true,
		headBlend = true,
		faceFeatures = true,
		headOverlays = true,
		components = true,
		props = true,
	}

	exports['fivem-appearance']:startPlayerCustomization(function (appearance)
		if (appearance) then
			TriggerServerEvent("SS:Console:Print", json.encode(SSCore:GetSkin()))
		else
			print('Canceled')
		end
	end, config)
end, false)