if GetCurrentResourceName() == 'SSCore' then 
    function getSharedObject()
        return SS
    end

    exports('getSharedObject', getSharedObject)
end

SS = exports['SSCore']:getSharedObject()