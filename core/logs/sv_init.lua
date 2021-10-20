SS.Logs = {}

function SS.Logs.CreateLog(message, source, source2, coords) 
    local player = source
    local targetPlayer = source2
    local event = message
    local location = coords

    if event and location and player then
        if not targetPlayer then  
            PerformHttpRequest(SS.Logs.DiscordWebhook, function(err, text, headers) end, 'POST', json.encode({
                username = Config.username, 
                embeds = {{
                    ["color"] = 255,255,255, 
                    ["author"] = {
                        ["name"] = SS.Logs.CommunityName,
                        ["icon_url"] = SS.Logs.IconURL
                    },
                    ["title"] = GetTitle(channel),
                    ["description"] = "".. message .."",
                    ["footer"] = {
                        ["text"] = SS.Logs.FooterText.." • "..os.date("%x %X %p"),
                        ["icon_url"] = SS.Logs.FooterIcon,
                    },
                }}, 
                avatar_url = SS.Logo.Avatar
            }), { 
                ['Content-Type'] = 'application/json' 
            })
        else
           
        end 
    end 

end