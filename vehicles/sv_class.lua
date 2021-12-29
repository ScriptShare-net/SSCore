function SS.Vehicles.Create(id, model, coords, heading)
    local self = {}
    
    self.model = model
    self.coords = coords
    self.heading = heading
    self.id = id

    self.MetaData = {}

    self.GetCoords = function(vehicle)
        return self.coords
    end

    self.SetCoords = function(vehicle, coords)
        if DoesEntityExist(vehicle) then 
            SetEntityCoords(vehicle, coords, coords.x, coords.y, coords.z, false)
        end
    end

    self.GetModel = function(vehicle)
        return model
    end

    self.vehicle = CreateVehicle(self.model, self.coords, self.heading, true, false)

    self.NetworkID = NetworkGetNetworkIdFromEntity(self.vehicle)

    SS.Vehicles.List[id] = self
end