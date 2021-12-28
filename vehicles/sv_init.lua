SS.Vehicles.List = {}

function SS.Vehicle.Delete(NetworkID)
    local vehicle = SS.Vehicles.List[NetworkID].vehicle
    if DoesEntityExist(vehicle) then 
        SetModelAsNoLongerNeeded(vehicle)
        DeleteEntity(vehicle)
    end
    SS.Vehicles.List[NetworkID] = nil
end