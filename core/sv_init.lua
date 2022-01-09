StopResource("hardcap")
StopResource("mapmanager")
StopResource("spawnmanager")
StopResource("sessionmanager")
StopResource("basic-gamemode")

local Config = {}

exports("SetConfigValue", function(name, value)
	Config[name] = value
end)

exports("GetConfigValue", function(name)
	return Config[name]
end)