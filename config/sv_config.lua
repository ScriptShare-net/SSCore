SS = SS or {}

SS.ServerName = "ScriptShare.net"

SS.TimeZone = 10 -- UTC +

SS.Queue = {}
SS.Queue.Slots = 60 -- Set how many not reserved slots you want. So if you have 64 server slots but want 4 reserved put 60.
SS.Queue.Discord = "https://discord.gg/CBTtWXQE6Q" -- Discord Link
SS.Queue.Forum = "https://discord.gg/CBTtWXQE6Q" -- Forum Link
SS.Queue.Banner = "https://media.discordapp.net/attachments/717607043443458070/788276497139236894/Fivem-Banner.png?width=1260&height=138" -- Banner PNG 1260 * 138
SS.Queue.Appeal = "https://discord.gg/CBTtWXQE6Q" -- Appeal Link
SS.Queue.SkipPlayer = true -- Enable the Skip_Player command
SS.Queue.RemovePlayer = true -- Enable the Remove_Player command
SS.Queue.Whitelist = false -- Enable Group Whitelist
SS.Queue.Ranks = { -- ["Rank Name"] = Weight, Higher weight means slower queue. 0 means skip queue. You will need to have the amount of reserved slots available to skip queue.
	["Member"] = 100,
	["Donator"] = 50,
	["Staff"] = 25,
	["Owner"] = 1,
	["Reserved"] = 0,
}

SS.Identifier = 'discord' -- Primary identifer (discord, license)

SS.Player.bloodtypes = { -- Not used
"A+", "B+", "AB+", "A-", "B-", "AB-", "O+", "O-"
}

SS.Logs.DiscordWebhook = ""
SS.Logs.CommunityName = "ScriptShare.net"
SS.Logs.IconURL = "" -- URL
SS.Logs.FooterText = "Powered by ScriptShare.net"
SS.Logs.FooterIcon = "" -- URL
SS.Logo.Avatar = "" -- Avatar

SS.Selector.Limit = 3 -- Set how many characters max
SS.Selector.Ranks = {
	["Twitch"] = 4,
	["Donator"] = 5,
}