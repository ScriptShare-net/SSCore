local disabledKeys = {}
local controlList = {}
local registered = {}
local disableMovement = false

exports("controlsRegister", function(key, label, onPressed, onReleased, onHeld)
    local id = "ss_"..string.lower(string.gsub(label, " ", ""))
    disabledKeys[key] = false
    controlList[id] = false
	registered[label] = {
		id = id,
		key = key,
	}

    RegisterCommand("+"..id, function()
        if (not disabledKeys[key]) then
            controlList[id] = true

            if onPressed then onPressed() end

            if onHeld then
                while controlList[id] and onHeld do
                    Wait(0)
                    onHeld()
                end
            end
        end 
    end)

    RegisterCommand("-"..id, function()
        if (not disabledKeys[key]) then
            controlList[id] = false
            if onReleased then onReleased() end
        end
    end)

	RegisterKeyMapping("+"..id, label, "keyboard", key)
end)

exports("controlsDisable", function(key, toggle)
    disabledKeys[key] = toggle
end)

exports("controlsDisableAll", function(toggle)
    for key in pairs(disabledKeys) do
        disabledKeys[key] = toggle
    end
end)