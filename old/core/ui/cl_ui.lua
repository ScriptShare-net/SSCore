local function DrawText3Ds(x,y,z, text)
	local onScreen, _x, _y = World3dToScreen2d(x,y,z)
	local px, py, pz = table.unpack(GetGameplayCamCoords())
	local pedcoords = GetEntityCoords(PlayerPedId())
	local dist = GetDistanceBetweenCoords(x, y, z, pedcoords.x, pedcoords.y, pedcoords.z, true)

	if dist >= 10 then return end
	
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
    SetTextEdge(3, 0, 0, 0, 255)
	SetTextOutline() 
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
	DrawText(_x, _y)
end

exports("uiDrawText", DrawText3Ds)