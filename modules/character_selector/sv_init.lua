local SSCore = exports["SSCore"]

if SSCore:GetConfigValue("CharacterSelector") then
	SSCore:Alert("Character CharacterSelector - Enabled")

	local next = next

	local createCharacter = {
		FirstName = "Create",
		LastName = "Character",
		DOB = "",
		Job = {
			NameLabel = "Unemployeed",
			GradeLabel = "Unemployeed",
		},
		Gang = {
			NameLabel = "Unemployeed",
			GradeLabel = "Unemployeed",
		},
		Coords = "",
		Health = "",
		Skin = {
			model = "mp_m_freemode_01",
			sex = 0,
			skin = {
				shapeFirst = 0,
				shapeSecond = 0,
				shapeThird = 0.0,
				shapeMix = 50,
				skinFirst = 0,
				skinSecond = 0,
				skinThird = 0.0,
				lip_thickness = 0,
				skinMix = 0.5,
				thirdMix = 0.0,
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

	exports("GetCharacterLimit", function(identifier, cb)
		local characterLimit = SSCore:GetConfigValue(CharacterSelectorLimit)
		MySQL.query("SELECT Groups FROM users WHERE Identifier = @identifier", {
			["@identifier"] = identifier
		}, function(result)
			if result.groups then
				for _, name in pairs(groups) do
					for name2, limit in pairs(SSCore:GetGroups()) do
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
			cb(characterLimit, 1)
		end)
	end)

	local function getCharacters(identifier, limit, cb)
		local characters = {}
		MySQL.query("SELECT * FROM Characters WHERE Identifier = @identifier", {
			["@identifier"] = identifier
		}, function(result)
			if next(result) then
				for i = 1, limit do
					if result[i] then
						local metadata = json.decode(result[i].MetaData)
						metadata.FirstName = result[i].FirstName
						metadata.LastName = result[i].LastName
						characters[i] = metadata
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

	local function CharacterSelectorInitiate(identifier, src)
		SSCore:GetCharacterLimit(identifier, function(characterLimit, favchar)
			getCharacters(identifier, characterLimit, function(characters)
				local characters = characters
				characters.Favourite = favchar
				characters.Max = characterLimit
				if characterLimit == 1 then
					--spawn only character
					return
				end
				TriggerClientEvent("SS:Client:Initiate", src, characters)
			end)
		end)
	end

	function CreateIdentity(identifier, characterid, data, callback)
		local skin = createCharacter.Skin
		skin.sex = data.sex
		if skin.sex then skin.model = "mp_f_freemode_01" end
		MySQL.query("SELECT CharacterSlot FROM Characters WHERE Identifier = @identifier AND CharacterSlot = @characterSlot", {
			["@identifier"] = identifier,
			["@characterSlot"] = characterid,
		}, function(result)
			if not next(result) then
				local metadata = {
					Skin = skin,
					DOB = data.dob.d .. "/" .. data.dob.m .. "/" .. data.dob.y,
					Job = {
						NameLabel = "Unemployeed",
						GradeLabel = "Unemployeed",
					},
					Gang = {
						NameLabel = "None",
						GradeLabel = "None",
					}
				}
				MySQL.query("INSERT INTO Characters (PermID, Identifier, CharacterSlot, FirstName, LastName, MetaData) VALUES (@permid, @identifier, @characterSlot, @firstName, @lastName, @metadata)", {
					["@permid"] = SSCore:GetPermIDFromIdentifier(identifier),
					['@identifier'] = identifier,
					['@characterSlot'] = characterid,
					['@firstName'] = data.FirstName,
					['@lastName'] = data.LastName,
					["@metadata"] = json.encode(metadata),
				},
				function(done)
					if callback then
						callback(true)
					end
				end)
			end
		end)
	end

	RegisterNetEvent("SS:Server:ClientLoaded", function(src)
		SSCore:Alert("Client Loaded: " .. src)
		if not SSCore:GetCharacterFromSource(src) then
			SSCore:GetUserIdentifiers(src, function(identifiers)
				CharacterSelectorInitiate(identifiers.Identifier, src)
			end)
		else
			DropPlayer(src, "cheater")
		end
	end)

	RegisterNetEvent("SS:Server:RegisterIdentity", function(data, charid)
		if data.FirstName == "Create" then return end
		local src = source
		SSCore:GetUserIdentifiers(src, function(identifiers)
			CreateIdentity(identifiers.Identifier, charid, data, function(created)
				if created then
					TriggerClientEvent("SS:Client:CreateSkin", src)
					if SSCore:GetCharacterFromSource(src) then
						DropPlayer(src, "Cheater")
					else
						SSCore:CreateCharacter(identifiers, src, charid)
					end
				end
			end)
		end)
	end)

	SSCore:RegisterServerCallback("SS:Server:GetRandomFemale", function(source, cb)
		local skin, cosmetics, clothing, tattoos = {}, {}, {}, {}
		MySQL.query("SELECT MetaData FROM Characters WHERE LOCATE('mp_f_freemode_01', MetaData)", {}, function(result)
			local characternum
			if not result[1] then
				cb(createCharacter.Skin.skin, createCharacter.Skin.cosmetics, createCharacter.Skin.clothing, createCharacter.Skin.tattoos)
			else
				characternum = math.random(1, #result)
				if result[characternum].MetaData.Skin then
					cb(result[characternum].MetaData.Skin.skin, result[characternum].MetaData.Skin.cosmetics, result[characternum].MetaData.Skin.clothing, result[characternum].MetaData.Skin.tattoos)
				else
					cb(createCharacter.Skin.skin, createCharacter.Skin.cosmetics, createCharacter.Skin.clothing, createCharacter.Skin.tattoos)
				end
			end
		end)
	end)

	SSCore:RegisterServerCallback("SS:Server:GetRandomMale", function(source, cb)
		local skin, cosmetics, clothing, tattoos = {}, {}, {}, {}
		MySQL.query("SELECT * FROM characters WHERE LOCATE('mp_m_freemode_01', MetaData)", {}, function(result)
			local characternum
			if not result[1] then
				cb(createCharacter.Skin.skin, createCharacter.Skin.cosmetics, createCharacter.Skin.clothing, createCharacter.Skin.tattoos)
			else
				characternum = math.random(1, #result)
				if result[characternum].MetaData.Skin then
					cb(result[characternum].MetaData.Skin.skin, result[characternum].MetaData.Skin.cosmetics, result[characternum].MetaData.Skin.clothing, result[characternum].MetaData.Skin.tattoos)
				else
					cb(createCharacter.Skin.skin, createCharacter.Skin.cosmetics, createCharacter.Skin.clothing, createCharacter.Skin.tattoos)
				end
			end
		end)
	end)

	RegisterNetEvent("SS:Server:CreatePlayer", function(charID)
		local src = source
		SSCore:GetUserIdentifiers(src, function(identifiers)
			if SSCore:GetCharacterFromSource(src) then
				DropPlayer(src, "Cheater")
			else
				SSCore:CreateCharacter(identifiers, src, charID)
			end
		end)
	end)

	RegisterNetEvent("SS:Server:SpawningPlayer", function()
		local src = source
		local xPlayer = SSCore:GetCharacterFromSource(src)
		if not xPlayer.spawned then
			xPlayer.spawned = true
			TriggerEvent("SS:Server:CharacterSelected", src, charID)
			TriggerClientEvent("SS:Client:CharacterSelected", src, xPlayer)
		else
			DropPlayer(src, "cheating")
		end
	end)

	RegisterNetEvent("SS:Server:SetSkin", function(skin)
		local src = source
		local xPlayer = SSCore:GetCharacterFromSource(src)
		if not xPlayer.spawned then
			xPlayer.MetaData.Skin = skin
		else
			DropPlayer(src, "cheating")
		end
	end)
end
