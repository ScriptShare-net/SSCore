SS.Selector = SS.Selector or {}
SS.Selector.Ranks = SS.Selector.Ranks or {}

function SS.Selector.GetLimit(identifier, cb)
	local characterLimit = SS.Selector.Limit
	exports.oxmysql:execute("SELECT groups FROM users WHERE identifier = @identifier", {
		["@identifier"] = identifier
	}, function(groups)
		if groups then
			for _, name in pairs(groups) do
				for name2, limit in pairs(SS.Selector.Ranks) do
					if name == name2 then
						if characterLimit then
							if characterLimit < limit then
								characterLimit = limit
							end
						else
							characterLimit = limit
						end
					end
				end
			end
		end
		cb(characterLimit)
	end)
end

local function getCharacters(identifier, limit, cb)
	local characters = {}
	exports.oxmysql:execute("SELECT * FROM characters WHERE identifier = @identifier", {
		["@identifier"] = identifier
	}, function(result)
		if result then
			for i = 1, limit do
				characters[i] = result[i]
			end
			return characters
		else
			for i = 1, limit do
				characters[i] = {
					firstName = "Create",
					lastName = "Character",
					dob = "",
					job = "",
					group = "",
					coords = "",
					health = "",
					skin = {
						model = "mp_m_freemode_01",
						sex = 0,
						skin = {
							mother = 0,
							father = 0,
							shapemix = 50,
							colour = 0,
							lip_thickness = 0,
							neck_thickness = 0,

							freckles = {texture = 0, opacity = 0},
							age = {texture = 0, opacity = 0},
							damage = {texture = 0, opacity = 0},
							complexion = {texture = 0, opacity = 0},
							blemish = {texture = 0, opacity = 0},

							nose = {width = 0, heigh = 0, twist = 0, peak_height = 0, peak_length = 0, peak_lowering = 0},
							cheeks = {width = 0, height = 0, chub = 0},
							eyes = {size = 0, colour = 0, brow_height = 0, brow_forward = 0},
							jaw = {width = 0, length = 0},
							chin = {lower = 0, length = 0, width = 0, tip = 0}
						},
						cosmetics = {
							head = {style = 1, thickness = 100, colour = 0, highlights = 0},
							beard = {style = 0, thickness = 0, colour = 0, highlights = 0},
							chest = {style = 0, thickness = 0, colour = 0, highlights = 0},
							eyebrows = {style = 0, thickness = 0, colour = 0, highlights = 0},
							lipstick = {style = 0, thickness = 0, colour = 0, highlights = 0},
							makeup = {style = 0, thickness = 0, colour = 0, highlights = 0},
							blush = {style = 0, thickness = 0, colour = 0, highlights = 0},
						},
						clothing = {
							helmet = {model = -1, texture = 0},
							glasses = {model = 0, texture = 0},
							ears = {model = -1, texture = 0},
							mask = {model = 0, texture = 0},
							torso = {model = 0, texture = 0},
							tshirt = {model = 0, texture = 0},
							arms = {model = 0, texture = 0},
							chain = {model = 0, texture = 0},
							watch = {model = -1, texture = 0},
							bracelet = {model = -1, texture = 0},
							pants = {model = 0, texture = 0},
							shoes = {model = 0, texture = 0},
							decals = {model = 0, texture = 0},
							bproof = {model = 0, texture = 0},
							bag = {model = 0, texture = 0},
						},
						tattoos = {},
					}
				}
			end
			cb(characters)
		end
	end)
end

function SS.Selector.Initiate(identifier, src)
	print("initiate")
	SS.Selector.GetLimit(identifier, function(characterLimit)
		getCharacters(identifier, characterLimit, function(characters)
			if characterLimit == 1 then
				--spawn only character
				return
			end
			TriggerClientEvent("ss:Client:Initiate", src, characters)
		end)
	end)
end

local function plyId(source, cb)
    local identifiers = {
        ["source"] = source,
        ["gta"] = "nil",
        ["steam"] = "nil",
        ["discord"] = "nil",
        ["live"] = "nil",
        ["xbox"] = "nil",
        ["fivem"] = "nil",
        ["ip"] = "nil",
        ["gta2"] = "nil",
        ["tokens"] = {},
    }

    for k,v in pairs(GetPlayerIdentifiers(source)) do
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
            identifiers.steam = string.sub(v, 7)
        elseif string.sub(v, 1, string.len("license:")) == "license:" then
            identifiers.gta = string.sub(v, 9)
        elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
            identifiers.discord = string.sub(v, 9)
        elseif string.sub(v, 1, string.len("live:")) == "live:" then
            identifiers.live = string.sub(v, 6)
        elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
            identifiers.ip = string.sub(v, 4)
        elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
            identifiers.xbox = string.sub(v, 5)
        elseif string.sub(v, 1, string.len("fivem:")) == "fivem:" then
            identifiers.fivem = string.sub(v, 7)
        elseif string.sub(v, 1, string.len("license2:")) == "license2:" then
            identifiers.gta2 = string.sub(v, 10)
        else
            print("FOUND NEW IDENTIFIER: "..tostring(v))
        end
    end

	cb(identifiers)
end

RegisterNetEvent("ss:Server:Initiate", function()
	print("initiate1")
	local src = source
	if not SS.Player.GetPlayerFromSource(src) then
		plyId(src, function(identifiers)
			SS.Selector.Initiate(identifiers[SS.Identifier], src)
		end)
	else
		DropPlayer(src, "cheater")
	end
end)