RegisterCommand("test1", function(s, args, r)
    local player = SS.Player.GetPlayerFromSource(s)
    print(player)
end)