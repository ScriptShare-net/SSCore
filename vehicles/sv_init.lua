SS.Vehicles.List = {}

function SS.Vehicle.Delete(id)
    local vehicle = SS.Vehicles.List[id].vehicle
    if DoesEntityExist(vehicle) then 
        SetModelAsNoLongerNeeded(vehicle)
        DeleteEntity(vehicle)
    end
    SS.Vehicles.List[id] = nil
end