exports["SSCore"]:uiCreateCustom("Scoreboard", "SSCore", "core/ui/scoreboard/scoreboard.html")
Citizen.CreateThread(function()
	exports["SSCore"]:uiSendMessage("Scoreboard", {
		action = "updateServerInfo",
		maxPlayers = 32,
	})
end)

function UpdatePlayerTable(connectedPlayers)
	local formattedPlayerList, num = {}, 1
	local police = 0
	local players = 0

	for k,v in pairs(connectedPlayers) do
		if num == 1 then
			table.insert(formattedPlayerList, ('<tr class="players"><td>%s</td><td>%s</td>'):format(v.name, v.id))
			num = 2
		elseif num == 2 then
			table.insert(formattedPlayerList, ('<td>%s</td><td>%s</td>'):format(v.name, v.id))
			num = 3
		elseif num == 3 then
			table.insert(formattedPlayerList, ('<td>%s</td><td>%s</td>'):format(v.name, v.id))
			num = 4
		elseif num == 4 then
			table.insert(formattedPlayerList, ('<td>%s</td><td>%s</td></tr>'):format(v.name, v.id))
			num = 1
		end

		players = players + 1

		if v.job.nameLabel == 'Los Santos Police Department' or v.job.nameLabel == 'Federal Investigation Bureau' then
			police = police + 1
		end
	end
	
	if police >= 5 then
		house = "yes"
		convenience = "yes"
	elseif police >= 6 then
		drugs = "yes"
	elseif police >= 8 then
		bank = "yes"
		jewellery = "yes"
	else
		if police < 5 then
			house = "no"
			convenience = "no"
		elseif police < 6 then
			drugs = "no"
		elseif police < 8 then
			bank = "no"
			jewellery = "no"
		end
	end
	
	if num == 1 then
		table.insert(formattedPlayerList, '</tr>')
	end

	exports["SSCore"]:uiSendMessage("Scoreboard", {
		action  = 'updatePlayerList',
		players = table.concat(formattedPlayerList)
	})

	exports["SSCore"]:uiSendMessage("Scoreboard", {
		action = 'updatePlayerJobs',
		jobs   = {house = house, bank = bank, drugs = drugs, jewellery = jewellery, convenience = convenience, player_count = players}
	})
end

--[[ Citizen.CreateThread(function()
	RSG.Controls.register("delete", "Player List", function()
		menuvisible = "open"
		OpenScoreBoard(menuvisible)
	end, function()
		menuvisible = "close"
		OpenScoreBoard(menuvisible)
	end)
end) ]]

RegisterCommand('+scoreboard', function()
		menuvisible = "open"
		OpenScoreBoard(menuvisible)
end, false)

RegisterCommand('-scoreboard', function()
		menuvisible = "close"
		OpenScoreBoard(menuvisible)
end, false)

RegisterKeyMapping('+scoreboard', 'Scoreboard', 'keyboard', 'delete')

function OpenScoreBoard(bool)
	TriggerServerEvent("SS:Server:OpenScoreboard", bool)
end

RegisterNetEvent("SS:Client:OpenScoreboard", function(bool)
	exports["SSCore"]:uiSendMessage("Scoreboard", {
		action = bool
	})
end)

Citizen.CreateThread(function()
	local playMinute, playHour = 0, 0

	while true do
		Citizen.Wait(1000 * 60)
		playMinute = playMinute + 1
	
		if playMinute == 60 then
			playMinute = 0
			playHour = playHour + 1
		end

		exports["SSCore"]:uiSendMessage("Scoreboard", {
			action = 'updateServerInfo',
			playTime = string.format("%02dh %02dm", playHour, playMinute)
		})
	end
end)

RegisterNetEvent("SS:Client:ServerTime", function(playHour, playMinute)
	exports["SSCore"]:uiSendMessage("Scoreboard", {
		action = 'updateServerInfo',
		uptime = string.format("%02dh %02dm", playHour, playMinute)
	})
end)

RegisterNetEvent("SS:Client:ScoreboardPlayers", function(players)
	UpdatePlayerTable(players)
end)
