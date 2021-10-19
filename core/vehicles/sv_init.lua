SS.Vehicle = {}

function SS.Vehicle.Create()
    self.vehicle = 'adder'
    self.vehicleCoords = vector3(0,0,0)

    self.GetVehicleCoords = function(vehicle)
        local coords = GetEntityCoords(vehicle)

        return coords 
    end

    self.SetVehicleCoords = function(vehicle, coords)
        if DoesEntityExist(vehicle) then 
            SetEntityCoords(vehicle, coords, coords.x, coords.y, coords.z, false)
        end
    end

    self.GetVehicleModel = function(vehicle)
        local hash = GetHashKey(vehicle)

        return hash
    end

end

function SS.Vehicle.Delete(vehicle)
    if DoesEntityExist(vehicle) then 
        SetModelAsNoLongerNeeded(vehicle)
        DeleteEntity(vehicle)
    end
end