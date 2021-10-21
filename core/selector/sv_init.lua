SS.Selector = {}

function SS.Selector.GetLimit(src)
	local characterLimit
	exports.oxmysql:execute("SELECT groups FROM users WHERE identifier = @identifier", {
		["@identifier"] = identifier
	}, function(groups)
		for _, name in pairs(json.decode(groups)) do
			for name2, prio in pairs(SS.Selector.Ranks) do
				if name == name2 then
					if characterLimit then
						if characterLimit < prio then
							characterLimit = prio
						end
					else
						characterLimit = prio
					end
				end
			end
		end
		return characterLimit
	end)
end

function SS.Selector.Initiate(src)
	local characterLimit = SS.Selector.GetLimit(src)
	if characterLimit == 1 then
		--spawn only character
		return
	end
	
end