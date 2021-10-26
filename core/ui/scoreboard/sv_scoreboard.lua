local connectedPlayers = {}

Citizen.CreateThread(function()
	AddPlayersToScoreboard()
	local playMinute, playHour = 0, 0
	while true do
		Citizen.Wait(1000 * 60)
		playMinute = playMinute + 1
	
		if playMinute == 60 then
			playMinute = 0
			playHour = playHour + 1
		end
		TriggerClientEvent("SS:Client:ServerTime", -1, playHour, playMinute)
	end
end)

RegisterNetEvent("SS:Server:PlayerDisconnect", function(src)
	local xPlayer = SS.GetPlayerFromSource(src)
	local permID = xPlayer.permID
	connectedPlayers[permID] = nil
	AddPlayersToScoreboard()
end)

RegisterNetEvent("SS:Server:OpenScoreboard", function(bool)
	local src = source
	AddPlayersToScoreboard()
	TriggerClientEvent("SS:Client:OpenScoreboard", src, bool)
end)

local function GetDiscordName(id)
	local data = {}
	PerformHttpRequest("https://discordapp.com/api/users/"..id, function(errorCode, resultData, resultHeaders)
		data = json.decode(resultData)
	end, "GET", "", {["Content-Type"] = "application/json", ["Authorization"] = "Bot ODcwNTA2MDc5Nzc0MjEyMDk2.YQNv9g.SRmYQGoPb38U8nMcxZy-S5u9AWo"})
	while data == nil or json.encode(data) == "[]" do
        Citizen.Wait(0)
	end
	return data.username .. "#" .. data.discriminator
end

function AddPlayerToScoreboard(xPlayer)
	local permID = xPlayer.permID
	connectedPlayers[permID] = {}
	connectedPlayers[permID].id = permID
	connectedPlayers[permID].name = GetDiscordName(xPlayer.identifiers.discord)
	connectedPlayers[permID].job = xPlayer.job
	TriggerClientEvent("SS:Client:ScoreboardPlayers", -1, connectedPlayers)
end

function AddPlayersToScoreboard()
	connectedPlayers = {}
	local players = SS.Players
	if players == {} then return end
	for i=1, #players, 1 do
		local xPlayer = SS.GetPlayerFromSource(i)
		AddPlayerToScoreboard(xPlayer)
	end
end