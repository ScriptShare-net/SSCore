SS.Users.List = {}

RegisterNetEvent("SS:Server:ClientLoad", function()
	local src = source
	if not SS.Users.List[source].Loaded then
		TriggerEvent("SS:Server:ClientLoaded", src)
		SS.Users.List[source].Loaded = true
	end
end)