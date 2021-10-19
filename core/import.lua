SSCore = exports['SSCore']:getSharedObject()

if GetCurrentResourceName() == 'SSCore' then 
    function getSharedObject()
        return SSCore
    end

    exports('getSharedObject', getSharedObject())
end