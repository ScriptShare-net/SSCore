local Vehicles = {}

exports("CreateVehicle", function(id, model, coords, heading)
    local self = {}
    
    self.Model = model
    self.Coords = coords
    self.Heading = heading
    self.ID = id

    self.MetaData = {}

    self.GetCoords = function(vehicle)
        return self.Coords
    end

    self.SetCoords = function(vehicle, coords)
        if DoesEntityExist(vehicle) then 
            SetEntityCoords(vehicle, coords, coords.x, coords.y, coords.z, false)
        end
    end

    self.GetModel = function(vehicle)
        return model
    end

    self.Vehicle = CreateVehicle(self.Model, self.Coords, self.Heading, true, false)

    self.NetworkID = NetworkGetNetworkIdFromEntity(self.Vehicle)

    Vehicles[id] = self
end)

exports("DeleteVehicle", function(id)
    local vehicle = Vehicles[id].vehicle
    if DoesEntityExist(vehicle) then 
        SetModelAsNoLongerNeeded(vehicle)
        DeleteEntity(vehicle)
    end
    Vehicles[id] = nil
end)

CreateThread(function()
    MySQL.query("SELECT * FROM Vehicles", {}, function(vehiclestable)
        if vehiclestable then
            for k,v in pairs(vehiclestable) do
                Vehicles[v.ID] = v
            end
        end
    end)
end)