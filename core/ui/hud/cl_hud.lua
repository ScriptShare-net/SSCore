exports["SSCore"]:uiCreateCustom("HUD", "SSCore", "core/ui/hud/hud.html")
--Names
directions = {
    [0] = 'N',
    [1] = 'NW', 
    [2] = 'W',
    [3] = 'SW',
    [4] = 'S',
    [5] = 'SE',
    [6] = 'E',
    [7] = 'NE',
    [8] = 'N'
}

zones = {
	['AIRP'] = "Los Santos International Airport", 
	['ALAMO'] = "Alamo Sea", 
	['ALTA'] = "Alta", 
	['ARMYB'] = "Fort Zancudo", 
	['BANHAMC'] = "Banham Canyon Dr", 
	['BANNING'] = "Banning", 
	['BEACH'] = "Vespucci Beach", 
	['BHAMCA'] = "Banham Canyon", 
	['BRADP'] = "Braddock Pass", 
	['BRADT'] = "Braddock Tunnel", 
	['BURTON'] = "Burton", 
	['CALAFB'] = "Calafia Bridge", 
	['CANNY'] = "Raton Canyon", 
	['CCREAK'] = "Cassidy Creek", 
	['CHAMH'] = "Chamberlain Hills", 
	['CHIL'] = "Vinewood Hills", 
	['CHU'] = "Chumash", 
	['CMSW'] = "Chiliad Mountain State Wilderness", 
	['CYPRE'] = "Cypress Flats", 
	['DAVIS'] = "Davis", 
	['DELBE'] = "Del Perro Beach", 
	['DELPE'] = "Del Perro", 
	['DELSOL'] = "La Puerta", 
	['DESRT'] = "Grand Senora Desert", 
	['DOWNT'] = "Downtown", 
	['DTVINE'] = "Downtown Vinewood", 
	['EAST_V'] = "East Vinewood", 
	['EBURO'] = "El Burro Heights", 
	['ELGORL'] = "El Gordo Lighthouse", 
	['ELYSIAN'] = "Elysian Island", 
	['GALFISH'] = "Galilee", 
	['GOLF'] = "GWC and Golfing Society", 
	['GRAPES'] = "Grapeseed", 
	['GREATC'] = "Great Chaparral", 
	['HARMO'] = "Harmony", 
	['HAWICK'] = "Hawick", 
	['HORS'] = "Vinewood Racetrack", 
	['HUMLAB'] = "Humane Labs and Research", 
	['JAIL'] = "Bolingbroke Penitentiary", 
	['KOREAT'] = "Little Seoul", 
	['LACT'] = "Land Act Reservoir", 
	['LAGO'] = "Lago Zancudo", 
	['LDAM'] = "Land Act Dam", 
	['LEGSQU'] = "Legion Square", 
	['LMESA'] = "La Mesa", 
	['LOSPUER'] = "La Puerta", 
	['MIRR'] = "Mirror Park", 
	['MORN'] = "Morningwood", 
	['MOVIE'] = "Richards Majestic", 
	['MTCHIL'] = "Mount Chiliad", 
	['MTGORDO'] = "Mount Gordo", 
	['MTJOSE'] = "Mount Josiah", 
	['MURRI'] = "Murrieta Heights", 
	['NCHU'] = "North Chumash", 
	['NOOSE'] = "N.O.O.S.E", 
	['OCEANA'] = "Pacific Ocean", 
	['PALCOV'] = "Paleto Cove", 
	['PALETO'] = "Paleto Bay", 
	['PALFOR'] = "Paleto Forest", 
	['PALHIGH'] = "Palomino Highlands", 
	['PALMPOW'] = "Palmer-Taylor Power Station", 
	['PBLUFF'] = "Pacific Bluffs", 
	['PBOX'] = "Pillbox Hill", 
	['PROCOB'] = "Procopio Beach", 
	['RANCHO'] = "Rancho", 
	['RGLEN'] = "Richman Glen", 
	['RICHM'] = "Richman", 
	['ROCKF'] = "Rockford Hills", 
	['RTRAK'] = "Redwood Lights Track", 
	['SANAND'] = "San Andreas", 
	['SANCHIA'] = "San Chianski Mountain Range", 
	['SANDY'] = "Sandy Shores", 
	['SKID'] = "Mission Row", 
	['SLAB'] = "Stab City", 
	['STAD'] = "Maze Bank Arena", 
	['STRAW'] = "Strawberry", 
	['TATAMO'] = "Tataviam Mountains", 
	['TERMINA'] = "Terminal", 
	['TEXTI'] = "Textile City", 
	['TONGVAH'] = "Tongva Hills", 
	['TONGVAV'] = "Tongva Valley", 
	['VCANA'] = "Vespucci Canals", 
	['VESP'] = "Vespucci", 
	['VINE'] = "Vinewood", 
	['WINDF'] = "Ron Alternates Wind Farm", 
	['WVINE'] = "West Vinewood", 
	['ZANCUDO'] = "Zancudo River", 
	['ZP_ORT'] = "Port of South Los Santos", 
	['ZQ_UAR'] = "Davis Quartz"
}

--Remove Old Hud
local HUD_ELEMENTS = {
    HUD = { id = 0, hidden = true },
    HUD_WANTED_STARS = { id = 1, hidden = true },
    HUD_WEAPON_ICON = { id = 2, hidden = false },
    HUD_CASH = { id = 3, hidden = true },
    HUD_MP_CASH = { id = 4, hidden = true },
    HUD_MP_MESSAGE = { id = 5, hidden = true },
    HUD_VEHICLE_NAME = { id = 6, hidden = true },
    HUD_AREA_NAME = { id = 7, hidden = true },
    HUD_VEHICLE_CLASS = { id = 8, hidden = true },
    HUD_STREET_NAME = { id = 9, hidden = true },
    HUD_HELP_TEXT = { id = 10, hidden = false },
    HUD_FLOATING_HELP_TEXT_1 = { id = 11, hidden = false },
    HUD_FLOATING_HELP_TEXT_2 = { id = 12, hidden = false },
    HUD_CASH_CHANGE = { id = 13, hidden = true },
    HUD_SUBTITLE_TEXT = { id = 15, hidden = false },
    HUD_RADIO_STATIONS = { id = 16, hidden = false },
    HUD_SAVING_GAME = { id = 17, hidden = false },
    HUD_GAME_STREAM = { id = 18, hidden = false },
    HUD_WEAPON_WHEEL = { id = 19, hidden = false },
    HUD_WEAPON_WHEEL_STATS = { id = 20, hidden = false },
    MAX_HUD_COMPONENTS = { id = 21, hidden = false },
    MAX_HUD_WEAPONS = { id = 22, hidden = false },
    MAX_SCRIPTED_HUD_COMPONENTS = { id = 141, hidden = false }
}

-- Parameter for hiding radar when not in a vehicle
local HUD_HIDE_RADAR_ON_FOOT = true
local togglebelt = false
local togglelock = false

RegisterNetEvent("SS:Client:ToggleBelt", function()
	togglebelt = not togglebelt
end)


-- Main thread
Citizen.CreateThread(function()
    -- Loop forever and update HUD every frame
    while true do
        Citizen.Wait(0)

        -- If enabled only show radar when in a vehicle (use a zoomed out view)
			if HUD_HIDE_RADAR_ON_FOOT then
            local player = PlayerPedId()
            DisplayRadar(IsPedInAnyVehicle(player, false))
        end

        --Hide other HUD components
        for key, val in pairs(HUD_ELEMENTS) do
            if val.hidden then
                HideHudComponentThisFrame(val.id)
            end
        end
    end
end)

local playerwater = 100
local playerfood = 100

function updatefoodwater()
	status = 67
	--TriggerEvent('esx_status:getStatus', 'hunger', function(status)
		playerfood = status / 10000
	--end) -- FOOD
	--TriggerEvent('esx_status:getStatus', 'thirst', function(status)
		playerwater = status / 10000
	--end) -- WATER
end

Citizen.CreateThread(function()
	while true do
		Wait(5000)
		updatefoodwater()
	end
end)

--Speed & Fuel & Street
Citizen.CreateThread(function()
	local oldspeed = 0
	while true do
		Citizen.Wait(150)
		playerPed = PlayerPedId()
		if playerPed then
			if IsPedInAnyVehicle(playerPed, false) then
				SetRadarBigmapEnabled(false, false)
				playerCar = GetVehiclePedIsIn(playerPed, false)
				fuel = math.floor(GetVehicleFuelLevel(playerCar))
				speed = GetEntitySpeed(playerCar) * 3.6
				speed = math.floor(speed)
				oldspeed = speed
				engine = GetVehicleEngineHealth(GetVehiclePedIsIn(PlayerPedId()))
				talking = NetworkIsPlayerTalking(PlayerId())
				local health = math.floor(GetEntityHealth(playerPed) - 100)
				local armour = math.floor(GetPedArmour(playerPed))
				if health > 100 then health = 100 end
				if armour > 100 then armour = 100 end
				togglelock = GetVehicleDoorLockStatus(playerCar)
				if togglelock == 2 then
					togglelock = true
				else
					togglelock = false
				end

				exports["SSCore"]:uiSendMessage("HUD", {
					showhud = true,
					speed = speed,
					fuel = fuel,
					thirst = playerwater,
					hunger = playerfood,
					engine = engine,
					belt = togglebelt,
					lock = togglelock,
					talking = talking,
					healthshow = true,
					health = health,
					armour = armour,
				})
			else
				togglelock = false
				togglebelt = false
				local health = math.floor(GetEntityHealth(playerPed) - 100)
				local armour = math.floor(GetPedArmour(playerPed))
				talking = NetworkIsPlayerTalking(PlayerId())
				if health > 100 then health = 100 end
				if armour > 100 then armour = 100 end

				exports["SSCore"]:uiSendMessage("HUD", {
					showhud = false,
					healthshow = true,
					talking = talking,
					health = health,
					armour = armour,
					thirst = playerwater,
					hunger = playerfood,
				})
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)

		playerPed = PlayerPedId()
		local pos = GetEntityCoords(playerPed)
		local str1, str2 = GetStreetNameAtCoord(pos.x, pos.y, pos.z)
		local streetLabel = GetStreetNameFromHashKey(str1)
		if (str2 ~= 0) then streetLabel = streetLabel .. " & " .. GetStreetNameFromHashKey(str2) end
		local streetArea  = zones[GetNameOfZone(pos.x, pos.y, pos.z)]
		local direction = directions[math.floor((GetEntityHeading(PlayerPedId()) + 22.5) / 45.0)]
		exports["SSCore"]:uiSendMessage("HUD", {
			locations = true,
			road = streetLabel,
			suburb = streetArea,
			direction = direction,
		})
	end
end)

RegisterCommand("lockdebug", function(source,args,raw)
	playerPed = PlayerPedId()
	if playerPed then
		if IsPedInAnyVehicle(playerPed, false) then
			playerCar = GetVehiclePedIsIn(playerPed, false)
			print(GetVehicleDoorLockStatus(playerCar))
		end
	end
end)

Citizen.CreateThread(function()
    local minimap = RequestScaleformMovie("minimap")
    SetRadarBigmapEnabled(true, false)
    Wait(0)
    SetRadarBigmapEnabled(false, false)
    while true do
        Wait(0)
        BeginScaleformMovieMethod(minimap, "SETUP_HEALTH_ARMOUR")
        ScaleformMovieMethodAddParamInt(3)
        EndScaleformMovieMethod()
    end
end)

RegisterCommand("armour", function(r, args, s)
	SetPedArmour(PlayerPedId(), tonumber(args[1]))
end)

RegisterCommand("setfw", function(r, args, s)
	exports["SSCore"]:uiSendMessage("HUD", {
		hunger = args[1],
		thirst = args[2]
	})
end)