if SS.Config.Skin then
	SS.Skin = {}
	SS.Skin.HiddenClothing = {}
	SS.Skin.CurrentSkin = {}
	SS.Skin.SavedSkin = {}
	SS.Skin.ClothingToggles = {
		[0] = {
			helmet = -1,
			ears = -1,
			glasses = 0,
			mask = 0,
			chain = 0,
			watch = -1,
			bracelet = -1,
			tshirt = 15,
			torso = 15,
			arms = 15,
			shoes = 34,
			pants = 61,
			bproof = 0,
			decals = 0,
			bag = 0,
		},

		[1] = {
			helmet = -1,
			ears = -1,
			glasses = 5,
			mask = 0,
			chain = 0,
			watch = -1,
			bracelet = -1,
			tshirt = 14,
			torso = 15,
			arms = 15,
			shoes = 35,
			pants = 15,
			bproof = 0,
			decals = 0,
			bag = 0,
		}
	}

	SS.Skin.DefaultModels = {
		[0] = "mp_m_freemode_01",
		[1] = "mp_f_freemode_01",
	}

	SS.Skin.GetCurrentSkin = function()
		return SS.Skin.CurrentSkin
	end

	SS.Skin.GetSkin = function()
		SS.Skin.GetModel()
		SS.Skin.GetSkin()
		SS.Skin.GetTattoos()
		SS.Skin.GetClothing()
		SS.Skin.GetCosmetics()
	end

	SS.Skin.GetSavedSkin = function()
		return SS.Skin.SavedSkin
	end

	SS.Skin.SaveCurrentSkin = function()
		SS.Skin.SavedSkin = SS.Skin.CurrentSkin
		TriggerServerEvent("SS:Server:SaveSkin", SS.Skin.SavedSkin)
	end

	SS.Skin.LoadSavedSkin = function()
		SS.Skin.ApplyModel(SS.Skin.SavedSkin.model)
		SS.Skin.ApplySkin(SS.Skin.SavedSkin.skin)
		SS.Skin.ApplyTattoos(SS.Skin.SavedSkin.tattoos)
		SS.Skin.ApplyClothing(SS.Skin.SavedSkin.clothing)
		SS.Skin.ApplyCosmetics(SS.Skin.SavedSkin.cosmetics)
	end

	SS.Skin.LoadSkin = function(skin, entity)
		if not skin then
			skin = SS.Skin.SkinGetDefaults()
		end
		SS.Skin.ApplyModel(skin.model, entity)
		SS.Skin.ApplySkin(skin.skin, entity)
		SS.Skin.ApplyTattoos(skin.tattoos, entity)
		SS.Skin.ApplyClothing(skin.clothing, entity)
		SS.Skin.ApplyCosmetics(skin.cosmetics, entity)
	end

	SS.Skin.SkinGetDefaults = function()
		return {
			model = "mp_m_freemode_01",
			sex = 0,

			skin = SS.Skin.GetDefaultSkin(),
			cosmetics = SS.Skin.GetDefaultCosmetics(),
			clothing = SS.Skin.GetDefaultClothing(0),
			tattoos = {}
		}
	end

	SS.Skin.GetDefaultSkin = function()
		return {
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
		}
	end

	SS.Skin.GetDefaultCosmetics = function()
		return {
			head = {style = 1, thickness = 100, colour = 0, highlights = 0},
			beard = {style = 0, thickness = 0, colour = 0, highlights = 0},
			chest = {style = 0, thickness = 0, colour = 0, highlights = 0},
			eyebrows = {style = 0, thickness = 0, colour = 0, highlights = 0},
			lipstick = {style = 0, thickness = 0, colour = 0, highlights = 0},
			makeup = {style = 0, thickness = 0, colour = 0, highlights = 0},
			blush = {style = 0, thickness = 0, colour = 0, highlights = 0},
		}
	end

	SS.Skin.getDefaultClothing = function(gender)
		if not gender then
			return {
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
			}
		else
			return {
				helmet = {model = -1, texture = 0},
				glasses = {model = 5, texture = 0},
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
			}
		end
	end

	SS.Skin.ApplyModel = function(model, entity)
		local ped = entity or PlayerPedId()
		local modelHash = GetHashKey(model)

		if not IsModelValid(modelHash) then
			SS.Alert("[skin] Model didn't exist! Model: "..modelHash .. " for model " .. model)
			return false
		end

		RequestModel(modelHash)
		
		while not HasModelLoaded(modelHash) do
			Wait(1)
		end

		SetPlayerModel(ped, modelHash)
		SetPedDefaultComponentVariation(ped)

		if not entity then
			SS.Skin.CurrentSkin.model = model
			if model == "mp_f_freemode_01" then
				SS.Skin.CurrentSkin.sex = 1
			elseif model == "mp_m_freemode_01" then
				SS.Skin.CurrentSkin.sex = 0
			end
		end
	end

	SS.Skin.ApplySkin = function(skin, entity)
		local ped = entity or PlayerPedId()

		-- Head Manipulation
		SetPedHeadBlendData(ped, skin.shapeFirst, skin.shapeSecond, skin.shapeThird or 0.0, skin.skinFirst, skin.skinSecond, skin.skinThird or 0.0, (skin.shapeMix or 50)/100.0, skin.skinMix or 0.5, skin.thirdMix or 0.0, true)

		-- Nose Features
		if skin.nose then
			SetPedFaceFeature(ped, 0, (skin.nose.width or 0.0)/100.0)
			SetPedFaceFeature(ped, 1, (skin.nose.height or 0.0)/100.0)
			SetPedFaceFeature(ped, 2, (skin.nose.peak_length or 0.0)/100.0)
			SetPedFaceFeature(ped, 3, (skin.nose.peak_lowering or 0.0)/100.0)
			SetPedFaceFeature(ped, 4, (skin.nose.peak_height or 0.0)/100.0)
			SetPedFaceFeature(ped, 5, (skin.nose.twist or 0.0)/100.0)
		end

		-- Eyes
		if skin.eyes then
			SetPedEyeColor(ped, skin.eyes.colour)
			SetPedFaceFeature(ped, 6, (skin.eyes.brow_height or 0.0)/100.0)
			SetPedFaceFeature(ped, 7, (skin.eyes.brow_forward or 0.0)/100.0)
			SetPedFaceFeature(ped, 11, (skin.eyes.opening or 0.0)/100.0)
		end

		-- Cheeks
		if skin.cheeks then
			SetPedFaceFeature(ped, 8, (skin.cheeks.height or 0.0)/100.0)
			SetPedFaceFeature(ped, 9, (skin.cheeks.width or 0.0)/100.0)
			SetPedFaceFeature(ped, 10, (skin.cheeks.chub or 0.0)/100.0)
		end    

		-- Lips
		SetPedFaceFeature(ped, 12, (skin.lip_thickness or 0.0)/100.0)

		-- Jaw
		if skin.jaw then
			SetPedFaceFeature(ped, 13, (skin.jaw.width or 0.0)/100.0)
			SetPedFaceFeature(ped, 14, (skin.jaw.length or 0.0)/100.0)
		end

		-- Cheeks
		if skin.chin then
			SetPedFaceFeature(ped, 15, (skin.chin.lower or 0.0)/100.0)
			SetPedFaceFeature(ped, 16, (skin.chin.length or 0.0)/100.0)
			SetPedFaceFeature(ped, 17, (skin.chin.width or 0.0)/100.0)
			SetPedFaceFeature(ped, 18, (skin.chin.tip or 0.0)/100.0)
		end

		-- Neck
		SetPedFaceFeature(ped, 19, (skin.neck_thickness or 0.0)/100.0)

		-- Facial Features  
		if skin.blemish then
			SetPedHeadOverlay(ped, 0, skin.blemish.texture, (skin.blemish.opacity or 0.0)/100.0) -- Blemishes
		end

		SetPedHeadOverlay(ped, 3, skin.age.texture, (skin.age.opacity or 0.0)/100.0) -- Aging
		SetPedHeadOverlay(ped, 6, skin.complexion.texture, (skin.complexion.opacity or 0.0)/100.0) -- Complexion
		SetPedHeadOverlay(ped, 7, skin.damage.texture, (skin.damage.opacity or 0.0)/100.0) -- Sun Damage
		SetPedHeadOverlay(ped, 9, skin.freckles.texture, (skin.freckles.opacity or 0.0)/100.0) -- Moles-Freckles
		
		if not entity then
			SS.Skin.CurrentSkin.skin = skin
		end
	end

	SS.Skin.ApplyClothing = function(clothing, entity)
		local ped = entity or PlayerPedId()
		local clothing = clothing

		if not entity then
			for k, state in pairs(SS.Skin.HiddenClothing) do
				if state then
					clothing[k].model = SS.Skin.ClothingToggles[SS.Skin.CurrentSkin.sex][k]
				end
			end

			SS.Skin.CurrentSkin.clothing = clothing
		end

		-- Clothing Props
		if clothing.helmet.model == -1 then
			ClearPedProp(ped, 0)
		else
			SetPedPropIndex(ped, 0, clothing.helmet.model, clothing.helmet.texture, 2)
		end

		if clothing.ears.model == -1 then
			ClearPedProp(ped, 2)
		else
			SetPedPropIndex(ped, 2, clothing.ears.model, clothing.ears.texture, 2)
		end

		if clothing.watch == nil or clothing.watch.model == -1 then
			ClearPedProp(ped, 6)
		else
			SetPedPropIndex(ped, 6, clothing.watch.model, clothing.watch.texture, 2)
		end

		if clothing.bracelet == nil or clothing.bracelet.model == -1 then
			ClearPedProp(ped, 7)
		else
			SetPedPropIndex(ped, 7, clothing.bracelet.model, clothing.bracelet.texture, 2)
		end

		SetPedPropIndex(ped, 1, clothing.glasses.model, clothing.glasses.texture, 2)  -- Glasses

		-- Component Variations
		SetPedComponentVariation(ped, 8,  clothing.tshirt.model, clothing.tshirt.texture, 2) -- Undershirt
		SetPedComponentVariation(ped, 11, clothing.torso.model,  clothing.torso.texture, 2)  -- Torso
		SetPedComponentVariation(ped, 3,  clothing.arms.model,   clothing.arms.texture, 2)                        -- Arms
		SetPedComponentVariation(ped, 10, clothing.decals.model, clothing.decals.texture, 2) -- decals
		SetPedComponentVariation(ped, 4,  clothing.pants.model,  clothing.pants.texture, 2)  -- pants
		SetPedComponentVariation(ped, 6,  clothing.shoes.model,  clothing.shoes.texture, 2)  -- shoes
		SetPedComponentVariation(ped, 1,  clothing.mask.model,   clothing.mask.texture, 2)   -- mask
		SetPedComponentVariation(ped, 9,  clothing.bproof.model, clothing.bproof.texture, 2) -- bulletproof
		SetPedComponentVariation(ped, 7,  clothing.chain.model,  clothing.chain.texture, 2)  -- chain
		SetPedComponentVariation(ped, 5,  clothing.bag.model,    clothing.bag.texture, 2)   -- Bag
	end

	SS.Skin.ApplyTattoos = function(tattoos, entity)
		local ped = entity or PlayerPedId()

		ClearPedDecorations(ped)

		for i, tattoo in ipairs(tattoos) do
			AddPedDecorationFromHashes(ped, GetHashKey(tattoo.collection), GetHashKey(tattoo.hash))
		end

		if not entity then
			SS.Skin.CurrentSkin.tattos = tattoos
		end
	end

	SS.Skin.ApplyCosmetics = function(cosmetics, entity)
		local ped = entity or PlayerPedId()

		if cosmetics.head then
			SetPedComponentVariation(ped, 2, cosmetics.head.style, 0, 2)
			SetPedHairColor(ped, cosmetics.head.colour, cosmetics.head.highlights)
		end

		-- Eyebrows
		if cosmetics.eyebrows then
			SetPedHeadOverlay(ped, 2, cosmetics.eyebrows.style, (cosmetics.eyebrows.thickness/100) + 0.0)
			SetPedHeadOverlayColor(ped, 2, 1, cosmetics.eyebrows.colour, cosmetics.eyebrows.highlights)
		end

		-- Beard
		if cosmetics.beard then
			SetPedHeadOverlay(ped, 1, cosmetics.beard.style, (cosmetics.beard.thickness/100) + 0.0)
			SetPedHeadOverlayColor(ped, 1, 1, cosmetics.beard.colour, cosmetics.beard.highlights)
		end

		-- Chest Hair
		if cosmetics.chest then
			SetPedHeadOverlay(ped, 10, cosmetics.chest.style, (cosmetics.chest.thickness/100) + 0.0)
			SetPedHeadOverlayColor(ped, 10, 1, cosmetics.chest.colour, cosmetics.chest.highlights)
		end

		-- Makeup
		if cosmetics.makeup then
			SetPedHeadOverlay(ped, 4, cosmetics.makeup.style, (cosmetics.makeup.thickness/100) + 0.0)
			SetPedHeadOverlayColor(ped, 4, 1, cosmetics.makeup.colour, cosmetics.makeup.highlights)
		end

		-- Lipstick
		if cosmetics.lipstick then
			SetPedHeadOverlay(ped, 8, cosmetics.lipstick.style, (cosmetics.lipstick.thickness/100) + 0.0)
			SetPedHeadOverlayColor(ped, 8, 2, cosmetics.lipstick.colour, cosmetics.lipstick.highlights)
		end

		-- Blush
		if cosmetics.blush then
			SetPedHeadOverlay(ped, 5, cosmetics.blush.style, (cosmetics.blush.thickness/100) + 0.0)
			SetPedHeadOverlayColor(ped, 5, 2, cosmetics.blush.colour, cosmetics.blush.highlights)
		end
		
		if not entity then
			SS.Skin.CurrentSkin.cosmetics = cosmetics
		end
	end

	--Get skin
	SS.Skin.GetModel = function(entity)
		local ped = entity or PlayerPedId()

		return GetEntityModel(ped)
	end

	function GetHeadBlendData(ped)
		return Citizen.InvokeNative(0x2746BD9D88C5C5D0, ped, Citizen.PointerValueIntInitialized(0), Citizen.PointerValueIntInitialized(0), Citizen.PointerValueIntInitialized(0), Citizen.PointerValueIntInitialized(0), Citizen.PointerValueIntInitialized(0), Citizen.PointerValueIntInitialized(0), Citizen.PointerValueFloatInitialized(0), Citizen.PointerValueFloatInitialized(0), Citizen.PointerValueFloatInitialized(0))
	end

	SS.Skin.GetSkin = function(entity)
		local ped = entity or PlayerPedId()

		local skin = {}

		-- Head Manipulation 
		local shapeFirst, shapeSecond, shapeThird, skinFirst, skinSecond, skinThird, shapeMix, skinMix, thirdMix  = GetHeadBlendData(ped)
		skin.mother = shapeFirst
		skin.father = shapeSecond
		skin.colour = skinFirst
		skin.shapemix = shapeMix * 100.0

		-- Nose Features
		skin.nose = {}
		skin.nose.width = GetPedFaceFeature(ped, 0) * 100.0
		skin.nose.height = GetPedFaceFeature(ped, 1) * 100.0
		skin.nose.peak_length = GetPedFaceFeature(ped, 2) * 100.0
		skin.nose.peak_lowering = GetPedFaceFeature(ped, 3) * 100.0
		skin.nose.peak_height = GetPedFaceFeature(ped, 4) * 100.0
		skin.nose.twist = GetPedFaceFeature(ped, 5) * 100.0

		-- Eyes
		skin.eyes = {}
		skin.eyes.colour = GetPedEyeColor(ped)
		skin.eyes.brow_height = GetPedFaceFeature(ped, 6) * 100.0
		skin.eyes.brow_forward = GetPedFaceFeature(ped, 7) * 100.0
		skin.eyes.opening = GetPedFaceFeature(ped, 11) * 100.0

		-- Cheeks
		skin.cheeks = {}
		skin.cheeks.height = GetPedFaceFeature(ped, 8) * 100.0
		skin.cheeks.width = GetPedFaceFeature(ped, 9) * 100.0
		skin.cheeks.chub = GetPedFaceFeature(ped, 10) * 100.0

		-- Lips
		skin.lip_thickness = GetPedFaceFeature(ped, 12) * 100.0

		-- Jaw
		skin.width = GetPedFaceFeature(ped, 13) * 100.0
		skin.length = GetPedFaceFeature(ped, 14) * 100.0

		-- Cheeks
		skin.chin = {}
		skin.chin.lower = GetPedFaceFeature(ped, 15) * 100.0
		skin.chin.length = GetPedFaceFeature(ped, 16) * 100.0
		skin.chin.width = GetPedFaceFeature(ped, 17) * 100.0
		skin.chin.tip = GetPedFaceFeature(ped, 18) * 100.0

		-- Neck
		skin.neck_thickness = GetPedFaceFeature(ped, 19) * 100.0

		-- Facial Features  
		local _, texture, _, _, opacity = GetPedHeadOverlayData(ped, 0)
		skin.blemish = {}
		skin.blemish.texture = texture + 1
		skin.blemish.opacity = opacity

		
		local _, texture, _, _, opacity = GetPedHeadOverlayData(ped, 3)
		skin.age = {}
		skin.age.texture = texture + 1
		skin.age.opacity = opacity
		
		local _, texture, _, _, opacity = GetPedHeadOverlayData(ped, 6)
		skin.complexion = {}
		skin.complexion.texture = texture + 1
		skin.complexion.opacity = opacity
		
		local _, texture, _, _, opacity = GetPedHeadOverlayData(ped, 7)
		skin.damage = {}
		skin.damage.texture = texture + 1
		skin.damage.opacity = opacity

		local _, texture, _, _, opacity = GetPedHeadOverlayData(ped, 9)
		skin.freckles = {}
		skin.freckles.texture = texture + 1
		skin.freckles.opacity = opacity
		
		return skin
	end

	SS.Skin.GetClothing = function(entity)
		local ped = entity or PlayerPedId()
		local clothing = {}

		-- Clothing Props
		clothing.helmet = {}
		clothing.helmet.model = GetPedPropIndex(ped, 0)
		clothing.helmet.texture = GetPedPropTextureIndex(ped, 0)

		clothing.ears = {}
		clothing.ears.model = GetPedPropIndex(ped, 2)
		clothing.ears.texture = GetPedPropTextureIndex(ped, 2)

		clothing.watch = {}
		clothing.watch.model = GetPedPropIndex(ped, 6)
		clothing.watch.texture = GetPedPropTextureIndex(ped, 6)

		clothing.bracelet = {}
		clothing.bracelet.model = GetPedPropIndex(ped, 7)
		clothing.bracelet.texture = GetPedPropTextureIndex(ped, 7)

		clothing.glasses = {}
		clothing.glasses.model = GetPedPropIndex(ped, 1)
		clothing.glasses.texture = GetPedPropTextureIndex(ped, 1)

		-- Component Variations
		clothing.tshirt = {}
		clothing.tshirt.model = GetPedDrawableVariation(ped, 8)
		clothing.tshirt.texture = GetPedTextureVariation(ped, 8)

		clothing.torso = {}
		clothing.torso.model = GetPedDrawableVariation(ped, 11)
		clothing.torso.texture = GetPedTextureVariation(ped, 11)
		
		clothing.arms = {}
		clothing.arms.model = GetPedDrawableVariation(ped, 3)
		clothing.arms.texture = GetPedTextureVariation(ped, 3)
		
		clothing.decals = {}
		clothing.decals.model = GetPedDrawableVariation(ped, 10)
		clothing.decals.texture = GetPedTextureVariation(ped, 10)
		
		clothing.pant = {}
		clothing.pants.model = GetPedDrawableVariation(ped, 4)
		clothing.pants.texture = GetPedTextureVariation(ped, 4)
		
		clothing.shoes = {}
		clothing.shoes.model = GetPedDrawableVariation(ped, 6)
		clothing.shoes.texture = GetPedTextureVariation(ped, 6)
		
		clothing.mask = {}
		clothing.mask.model = GetPedDrawableVariation(ped, 1)
		clothing.mask.texture = GetPedTextureVariation(ped, 1)
		
		clothing.bproof = {}
		clothing.bproof.model = GetPedDrawableVariation(ped, 9)
		clothing.bproof.texture = GetPedTextureVariation(ped, 9)
		
		clothing.chain = {}
		clothing.chain.model = GetPedDrawableVariation(ped, 7)
		clothing.chain.texture = GetPedTextureVariation(ped, 7)
		
		clothing.bag = {}
		clothing.bag.model = GetPedDrawableVariation(ped, 5)
		clothing.bag.texture = GetPedTextureVariation(ped, 5)
	end

	SS.Skin.GetTattoos = function(entity)
		local ped = entity or PlayerPedId()
		local tattoos = {}

		-- no idea how to find this

		return tattoos
	end

	SS.Skin.GetCosmetics = function(cosmetics, entity)
		local ped = entity or PlayerPedId()
		local cosmetics = {}

		cosmetics.head = {}
		cosmetics.head.style = GetPedDrawableVariation(ped, 2)
		cosmetics.head.colour = GetPedHairColor(ped)
		cosmetics.head.highlights = GetPedHairHighlightColor(ped)

		-- Eyebrows
		local _, style, colour, highlights, thickness = GetPedHeadOverlayData(ped, 2)
		cosmetics.eyebrows = {}
		cosmetics.eyebrows.style = style
		cosmetics.eyebrows.thickness = thickness * 100.0
		cosmetics.eyebrows.colour = colour
		cosmetics.eyebrows.highlights = highlights

		-- Beard
		local _, style, colour, highlights, thickness = GetPedHeadOverlayData(ped, 1)
		cosmetics.beard = {}
		cosmetics.beard.style = style
		cosmetics.beard.thickness = thickness * 100.0
		cosmetics.beard.colour = colour
		cosmetics.beard.highlights = highlights

		-- Chest Hair
		local _, style, colour, highlights, thickness = GetPedHeadOverlayData(ped, 10)
		cosmetics.chest = {}
		cosmetics.chest.style = style
		cosmetics.chest.thickness = thickness * 100.0
		cosmetics.chest.colour = colour
		cosmetics.chest.highlights = highlights

		-- Makeup
		local _, style, colour, highlights, thickness = GetPedHeadOverlayData(ped, 4)
		cosmetics.makeup = {}
		cosmetics.makeup.style = style
		cosmetics.makeup.thickness = thickness * 100.0
		cosmetics.makeup.colour = colour
		cosmetics.makeup.highlights = highlights

		-- Lipstick
		local _, style, colour, highlights, thickness = GetPedHeadOverlayData(ped, 8)
		cosmetics.lipstick = {}
		cosmetics.lipstick.style = style
		cosmetics.lipstick.thickness = thickness * 100.0
		cosmetics.lipstick.colour = colour
		cosmetics.lipstick.highlights = highlights

		-- Blush
		local _, style, colour, highlights, thickness = GetPedHeadOverlayData(ped, 5)
		cosmetics.blush = {}
		cosmetics.blush.style = style
		cosmetics.blush.thickness = thickness * 100.0
		cosmetics.blush.colour = colour
		cosmetics.blush.highlights = highlights
		
		return cosmetics
	end
end