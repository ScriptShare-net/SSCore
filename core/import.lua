SS = exports['SSCore']:getSharedObject()

if GetCurrentResourceName() == 'SSCore' then 
    function getSharedObject()
        return SS
    end

    exports('getSharedObject', getSharedObject())
end