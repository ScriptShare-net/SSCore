local SSCore = exports["SSCore"]

local types = SSCore:getConfigValue("LogTypes")
local bottoken = SSCore:getConfigValue("BotToken")

local function GetDiscordAvatar(id)
	local data = {}
	PerformHttpRequest("https://discordapp.com/api/users/"..id, function(errorCode, resultData, resultHeaders)
		data = json.decode(resultData)
	end, "GET", "", {["Content-Type"] = "application/json", ["Authorization"] = "Bot " + bottoken})
	while data == nil or json.encode(data) == "[]" do
        Citizen.Wait(0)
	end
	if data.avatar == nil then
		return "https://logowik.com/content/uploads/images/discord-new-20218785.jpg"
	else
		return "https://cdn.discordapp.com/avatars/" .. id .. "/" .. data.avatar .. ".png"
	end
end

local function GetDiscordName(id)
	local data = {}
	PerformHttpRequest("https://discordapp.com/api/users/"..id, function(errorCode, resultData, resultHeaders)
		data = json.decode(resultData)
	end, "GET", "", {["Content-Type"] = "application/json", ["Authorization"] = "Bot " + bottoken})
	while data == nil or json.encode(data) == "[]" do
        Citizen.Wait(0)
	end
	return data.username .. "#" .. data.discriminator
end

local createMessage(msg, discordid, identifier)
	local message = {
            userName = GetDiscordName(discordid),
            embeds = {{
                ["color"] = 3092790,
                ["title"] = "SSCore Logs - " + identifier,
                ["description"] = msg,
            }},
            avatar_url = GetDiscordAvatar(discordid)
        }
	return message
end

exports("createLog", function(source, type, message)
	local src = source
	local User = SSCore:getUserFromSource(src)
	local msg = createMessage(message, User.Identifiers.Discord, User.Identifier)
	PerformHttpRequest(types[type], function(err, text, headers) end, 'POST', json.encode(msg), {
		['Content-Type'] = 'application/json'
	})
end)

RegisterNetEvent("SS:Server:createLog", function(type, message)
	local src = source
	SSCore:createLog(source, type, message)
end)