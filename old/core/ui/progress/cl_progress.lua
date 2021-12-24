exports["SSCore"]:uiCreateCustom("Progress", "SSCore", "core/ui/progress/progress.html")

local progress

exports("progressStart", function(length, cb)
	if progress then return end
	progress = cb
	exports["SSCore"]:uiSendMessage("Progress", {
		start = true,
		length = length,
	})
end)

exports["SSCore"]:uiRegisterCallback("Progress", "finished", function(data)
	progress()
	progress = nil
end)