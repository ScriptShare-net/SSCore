SS.Selector = {}
SS.Selector.Characters = {}

local camera

local function loadSkin(skin)

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

local function loadCharacter(charID)
	local player = PlayerPedId()
	Wait(500)
	DoScreenFadeOut(10)
	loadSkin(SS.Selector.Characters[charID].skin)
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
end

RegisterNetEvent("ss:Client:Initiate", function(characters)
	exports["SSCore"].uiDisableAll()
	exports["SSCore"].uiEnable("Selector")
	SetNuiFocus(true, true)
	loadCharacter(1)
end)