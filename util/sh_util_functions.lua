function SS.Math.GenerateRandomNumber(min, max)
    math.randomseed(os.time() * math.random())
    local number = math.random(min, max)

    return number
end

function SS.Math.Round(number)
    local result = math.round(number)

    return result
end