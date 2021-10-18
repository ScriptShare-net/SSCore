function SS.GenerateRandomNumber(min, max, cb)
    math.randomseed(os.time())
    local number = math.random(min, max)

    cb(number)
end