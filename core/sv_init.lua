SS = {}
SS.Config = {}
SS.Connection = {}
SS.Bans = {}
SS.Groups = {}
SS.Users = {}
SS.Players = {}
SS.Vehicles = {}
SS.Gangs = {}

AddEventHandler('SS:sharedObject', function(cb)
	cb(SS)
end)

exports("sharedObject", function()
	return SS
end)