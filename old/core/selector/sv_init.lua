SS.Selector = SS.Selector or {}
SS.Selector.Ranks = SS.Selector.Ranks or {}

local next = next

local createCharacter = {
	firstName = "Create",
	lastName = "Character",
	dob = "",
	job = {
		nameLabel = "Unemployeed",
		gradeLabel = "Unemployeed",
	},
	group = {
		nameLabel = "Unemployeed",
		gradeLabel = "Unemployeed",
	},
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

function SS.Selector.GetLimit(identifier, cb)
	local characterLimit = SS.Selector.Limit
	exports.oxmysql:execute("SELECT groups, favchar FROM users WHERE identifier = @identifier", {
		["@identifier"] = identifier
	}, function(result)
		if result.groups then
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
		cb(characterLimit, result.favchar or 1)
	end)
end

local function getCharacters(identifier, limit, cb)
	local characters = {}
	exports.oxmysql:execute("SELECT * FROM characters WHERE identifier = @identifier", {
		["@identifier"] = identifier
	}, function(result)
		if next(result) then
			for i = 1, limit do
				if result[i] then
					result[i].skin = json.decode(result[i].skin)
					result[i].job = json.decode(result[i].job)
					result[i].group = json.decode(result[i].group)
					characters[i] = result[i]
				else
					characters[i] = createCharacter
				end
			end
			cb(characters)
		else
			for i = 1, limit do
				characters[i] = createCharacter
			end
			cb(characters)
		end
	end)
end

function SS.Selector.Initiate(identifier, src)
	SS.Selector.GetLimit(identifier, function(characterLimit, favchar)
		getCharacters(identifier, characterLimit, function(characters)
			local characters = characters
			characters.favourite = favchar
			characters.max = characterLimit
			if characterLimit == 1 then
				--spawn only character
				return
			end
			TriggerClientEvent("SS:Client:Initiate", src, characters)
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

	exports.oxmysql:execute("SELECT permid FROM users WHERE identifier = @identifier", {
        ["@identifier"] = identifiers[SS.Identifier]
    }, function(result)
        if next(result) then
            identifiers.permid = result[1].permid
        end
		cb(identifiers)
    end)
end

function CreateIdentity(identifier, characterid, data, callback)
	local skin = createCharacter.skin
	skin.sex = data.sex
	if skin.sex then skin.model = "mp_f_freemode_01" end
	exports.oxmysql:execute("SELECT characterSlot FROM characters WHERE identifier = @identifier AND characterSlot = @characterSlot", {
		["@identifier"] = identifier,
		["@characterSlot"] = characterid,
	}, function(result)
		print(json.encode(result))
		if not next(result) then
			exports.oxmysql:execute("INSERT INTO characters (identifier, characterSlot, firstName, lastName, skin, dob, job) VALUES (@identifier, @characterSlot, @firstName, @lastName, @skin, @dob, @job)", {
				['@identifier'] = identifier,
				['@characterSlot'] = characterid,
				['@firstName'] = data.firstName,
				['@lastName'] = data.lastName,
				["@skin"] = json.encode(skin),
				['@dob'] = data.dob.d .. "/" .. data.dob.m .. "/" .. data.dob.y,
				['@job'] = json.encode({
					nameLabel = "Unemployeed",
					gradeLabel = "Unemployeed",
				}),
			},
			function(done)
				if callback then
					callback(true)
				end
			end)
		end
	end)
end

RegisterNetEvent("SS:Server:Initiate", function()
	local src = source
	SS.Players[src] = nil
	if not SS.GetPlayerFromSource(src) then
		plyId(src, function(identifiers)
			SS.Selector.Initiate(identifiers[SS.Identifier], src)
		end)
	else
		DropPlayer(src, "cheater")
	end
end)

RegisterNetEvent("SS:Server:RegisterIdentity", function(data, charid)
	if data.firstName == "Create" then return end
	local src = source
	plyId(src, function(identifiers)
		CreateIdentity(identifiers[SS.Identifier], charid, data, function(created)
			if created then
				TriggerClientEvent("SS:Client:CreateSkin", src)
			end
		end)
	end)
end)

SS.RegisterServerCallback("SS:Server:GetRandomFemale", function(source, cb)
	local skin, cosmetics, clothing, tattoos = {}, {}, {}, {}
	exports.oxmysql:execute("SELECT * FROM characters WHERE LOCATE('mp_f_freemode_01', skin)", {}, function(result)
		local characternum = SS.Math.GenerateRandomNumber(1, #result)
		if result[characternum].skin then
			cb(result[characternum].skin, result[characternum].cosmetics, result[characternum].clothing, result[characternum].tattoos)
		else
			cb(createCharacter.skin.skin, createCharacter.skin.cosmetics, createCharacter.skin.clothing, createCharacter.skin.tattoos)
		end
	end)
end)

SS.RegisterServerCallback("SS:Server:GetRandomMale", function(source, cb)
	local skin, cosmetics, clothing, tattoos = {}, {}, {}, {}
	exports.oxmysql:execute("SELECT * FROM characters WHERE LOCATE('mp_m_freemode_01', skin)", {}, function(result)
		local characternum = SS.Math.GenerateRandomNumber(1, #result)
		if result[characternum].skin then
			cb(result[characternum].skin, result[characternum].cosmetics, result[characternum].clothing, result[characternum].tattoos)
		else
			cb(createCharacter.skin.skin, createCharacter.skin.cosmetics, createCharacter.skin.clothing, createCharacter.skin.tattoos)
		end
	end)
end)

RegisterNetEvent("SS:Server:CreatePlayer", function(charID)
	local src = source
	plyId(src, function(identifiers)
		if SS.Players[src] then
			DropPlayer(src, "Cheater")
		else
			SS.Player.Create(identifiers, src, charID)
			TriggerEvent("SS:Server:PlayerLoaded", src, charID)
			TriggerClientEvent("SS:Client:PlayerLoaded", src, SS.GetPlayerFromSource(src))
		end
	end)
	
end)