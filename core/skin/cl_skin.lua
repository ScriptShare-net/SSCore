local hiddenClothing = {}

exports("applyModel", function(model, entity)
    local ped = entity or PlayerId()
    local modelHash = GetHashKey(model)

    if not IsModelValid(modelHash) then
        print("[skin] Model didn't exist! Model: "..modelHash)
        return false
    end

	RequestModel(modelHash)
	
	while not HasModelLoaded(modelHash) do
		Wait(1)
	end

	SetPlayerModel(ped, modelHash)
	SetPedDefaultComponentVariation(ped)
end)

exports("applySkin", function(skin, entity)
    local ped = entity or PlayerPedId()

    -- Head Manipulation
    SetPedHeadBlendData(ped, skin.mother, skin.father, 0.0, skin.colour, skin.colour, 0.0, (skin.shapemix or 50)/100.0, 0.5, 0.0, true)

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
end)

exports("applyClothing", function(clothing, sex, entity)
    local ped = entity or PlayerPedId()
    local clothing = clothing

    for k, state in pairs(hiddenClothing) do
		if state then
			if sex == 0 then
				clothing[k].model = CLOTHING_TOGGLES[0][k]
			else
				clothing[k].model = CLOTHING_TOGGLES[1][k]
			end
        end
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
    SetPedComponentVariation(ped, 3,  clothing.arms.model,   0, 2)                        -- Arms
    SetPedComponentVariation(ped, 10, clothing.decals.model, clothing.decals.texture, 2) -- decals
    SetPedComponentVariation(ped, 4,  clothing.pants.model,  clothing.pants.texture, 2)  -- pants
    SetPedComponentVariation(ped, 6,  clothing.shoes.model,  clothing.shoes.texture, 2)  -- shoes
    SetPedComponentVariation(ped, 1,  clothing.mask.model,   clothing.mask.texture, 2)   -- mask
    SetPedComponentVariation(ped, 9,  clothing.bproof.model, clothing.bproof.texture, 2) -- bulletproof
    SetPedComponentVariation(ped, 7,  clothing.chain.model,  clothing.chain.texture, 2)  -- chain
    SetPedComponentVariation(ped, 5,  clothing.bag.model,    clothing.bag.texture, 2)   -- Bag
end)