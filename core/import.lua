SSCore = exports['SSCore']:getSharedObject()

if GetCurrentResourceName() == 'ss_framework' then 
    function getSharedObject()
        return SSCore
    end

    exports('getSharedObject', getSharedObject())
end