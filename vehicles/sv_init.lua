SS.Vehicles.List = {}

function SS.Vehicle.Delete(id)
    local vehicle = SS.Vehicles.List[id].vehicle
    if DoesEntityExist(vehicle) then 
        SetModelAsNoLongerNeeded(vehicle)
        DeleteEntity(vehicle)
    end
    SS.Vehicles.List[id] = nil
end

Citizen.CreateThread(function()
    exports.oxmysql:execute("SELECT * FROM Vehicles", {}, function(vehiclestable)
        if vehiclestable then
            for k,v in pairs(vehiclestable) do
                SS.Vehicles.List[v.ID] = v
            end
        end
    end)
end)