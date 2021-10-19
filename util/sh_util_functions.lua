SS.Math = {}
SS.Entity = {}

function SS.Math.GenerateRandomNumber(min, max)
    math.randomseed(os.time() * math.random())
    local number = math.random(min, max)

    return number
end

function SS.Math.Round(number)
    local result = math.round(number)

    return result
end

function SS.Entity.GetCoords(entity)
    local coords = GetEntityCoords(entity)
    local heading = GetEntityHeading(entity)
    local vec = vector4(coords, heading)
    
    return vec
end

function SS.RegisterServerCallback()
    
end