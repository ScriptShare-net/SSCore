SS.Function = {}

function SS.Function.RemoveProp()
    for k, v in pairs(GetGamePool('CObject')) do
        if IsEntityAttachedToEntity(PlayerPedId(), v) then
            SetEntityAsMissionEntity(v, true, true)
            DeleteObject(v)
            DeleteEntity(v)
        end
    end
end

function SS.Function.DrawText3D(coords, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(v, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 0)
    ClearDrawOrigin()
end

function SS.Function.spawnVehicle(hash, coords, veh)
    local ply = PlayerPedId()
    
    local vehicle = CreateVehicle(hash, coords, GetEntityHeading(ply), true, false)
    TaskWarpPedIntoVehicle(ply, vehicle, -1)
    SetModelAsNoLongerNeeded(vehicle) -- Unsure if this will effect distance checking with onesync infinity
end