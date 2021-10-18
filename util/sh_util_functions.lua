function SS.GenerateRandomNumber(min, max, cb)
    math.randomseed(os.time() * math.random())
    local number = math.random(min, max)

    cb(number)
end