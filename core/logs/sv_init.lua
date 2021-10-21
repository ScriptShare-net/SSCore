SS.Logs = {}

function SS.Logs.CreateLog(message, source, source2, coords) 
    local player = source
    local targetPlayer = source2
    local event = message
    local location = coords
    if event and location and player then
        if not targetPlayer then  
            PerformHttpRequest(SS.Logs.DiscordWebhook, function(err, text, head) end, 'POST', json.encode({
                username = "ScriptShare", 
                embeds = {{
                    ["color"] = 255,255,255, 
                    ["author"] = {
                        ["name"] = SS.Logs.CommunityName,
                        ["icon_url"] = SS.Logs.IconURL
                    },
                    ["title"] = "Test",
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
        end 
    end 
end