SS = SS or {}
SS.Utility = {}

function SS.Utility.SavePlayerData()
    CreateThread(function()
        Wait(SS.SaveTime * 60 * 1000) -- in minutes
        SS.Player.SaveAll()
    end)
end

function SS.RegisterServerCallback(name, cb)

end

function SS.TriggerServerCallback(name)
    
end