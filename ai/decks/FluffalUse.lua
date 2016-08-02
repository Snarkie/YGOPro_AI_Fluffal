------------------------
--------- USE ----------
------------------------
-- FluffalM Use
function UseBear(c)
  if CountToyVendorDiscardTarget() > 0 
  or HasID(AIHand(),72413000,true) -- Wings
  or HasID(AIHand(),67441435,true) -- Bulb
  or (not NormalSummonCheck() and HasID(AIHand(),39246582,true)) -- Dog
  then
    OPTSet(c.id)
    return true
  else
    return false
  end
end
function UseSheep(c)
  GlobalCheckFusionTarget = 1
  GlobalFusionSummon = 1
  local countF = CountFusionTarget()
  GlobalCheckFusionTarget = 0
  GlobalFusionSummon = 0
  
  if HasID(UseLists({AIHand(),AIST()},24094653,true)) -- Polymerization
  and countF > 0 then
    OPTSet(c.id)
    return true
  else
    return false
  end
end
function UseMouse(c)
  return true
end
function UseWings(c)
  if CountWingsTarget() > 0
  and CardsMatchingFilter(AIST(),ToyVendorCheckFilter,false) > 0
  then
    OPTSet(c.id)
	return true
  else
    return false
  end
end
-- EdgeImp Use
function UseTomahawk(c)
  OPTSet(c.id)
  return true
end
function UseSabres(c)
  OPTSet(c.id)
  return false
end
function UseBulb(c)
  if FieldCheck(4) > 0 
  and OPTCheck(06142488) -- Mouse
  and OppGetStrongestAttDef() <= 2100 then 
    OPDSet(c.id)
    return true
  else
    return false
  end
end
-- Other Use
function UseKoS(c)
  if not HasID(UseLists({AIST(),AIHand()}),24094653,true) -- Polymerization
  and (
    CountEgdeImp(AIHand(),AIMon()) > 0
	or Get_Card_Count_ID(AIHand(),c.id) > 1
  )
  then
    return true
  else
    return false
  end
end
function UseKoS2(c) -- When dont have cards to discard
  if CountToyVendorDiscardTarget() == 0
  and CardsMatchingFilter(AIST(),ToyVendorCheckFilter,true) > 0 
  and #AIHand() > 2 then
    return true
  else
    return false
  end
end

-- FluffalS Use
function ActiveToyVendor(c)
  return 
    CountToyVendorDiscardTarget() > 0 
	and (
	  #AIHand() > 2
	  or HasID(AIHand(),72413000,true) -- Wings
	)
end
function ActiveToyVendor2(c)
  return 
    CountToyVendorDiscardTarget() > 0 
    and (
	  #AIHand() > 2 
	  or HasID(AIHand(),72413000,true) -- Wings
	)
	and not HasID(AIST(),c.id) -- Toy Vendor
end
function UseToyVendor(c)
  if HasID(AIHand(),72413000,true) then -- Wings
	return true
  elseif 
  not NormalSummonCheck() and HasID(AIHand(),39246582,true) and OPTCheck(39246582) -- Dog
  and OPTCheck(72413000) and not HasID(AIGrave(),72413000,true) then -- Wings
	return false
  elseif (#AIHand() > 2 and CountToyVendorDiscardTarget() > 0) then
	return true
  else
    return false
  end
end

function ActiveFFactory(c)
  if FilterLocation(c,LOCATION_HAND) or FilterPosition(c,POS_FACEDOWN) then
    if HasID(AIGrave(),06077601,true) -- Frightfur Fusion
    or HasID(AIGrave(),01845204,true) -- Instant Fusion
	or Get_Card_Count_ID(AIGrave(),24094653) > 1 -- Polymerization
	then
	  GlobalCheckFusionTarget = 1
	  GlobalFusionSummon = 1
      local countF = CountFusionTarget()
      GlobalCheckFusionTarget = 0
	  GlobalFusionSummon = 0
      if countF > 0 then
        return true
      else
        return false
      end
	else
	  return false
	end
  else
    return false
  end
end
function UseFFactory(c)
  if FilterLocation(c,LOCATION_SZONE) then
    if HasID(AIGrave(),06077601,true) -- Frightfur Fusion
    or HasID(AIGrave(),01845204,true) -- Instant Fusion
	or Get_Card_Count_ID(AIGrave(),24094653) > 1 then -- Polymerization
      GlobalCheckFusionTarget = 1
	  GlobalFusionSummon = 1
      local countF = CountFusionTarget()
      GlobalCheckFusionTarget = 0
	  GlobalFusionSummon = 1
      if countF > 0 then
        return true
      else
        return false
      end
	else
	  return false
	end
  end
end

function UseFFusion(c)
  GlobalCheckFusionTarget = 1
  GlobalFFusion = 1
  local countF = CountFusionTarget()
  GlobalCheckFusionTarget = 0
  GlobalFFusion = 0
  if countF > 0 then
    return true
  else
    return false
  end
end
-- Spell Use
function UseIFusion(c)
  if HasID(AICards(),24094653,true) -- Polymerization
  and not HasID(AIMon(),80889750,true) -- Frightfur Sabre-Tooth
  and CountFluffal(UseLists({AIMon(),AIHand()})) > 1
  then
    OPTSet(c.id)
    return true
  else
    return false
  end
end

function UsePolymerization(c)
  GlobalCheckFusionTarget = 1
  GlobalFusionSummon = 1
  local countF = CountFusionTarget()
  GlobalCheckFusionTarget = 0
  GlobalFusionSummon = 0
  if countF > 0 then
    return true
  else
    return false
  end
end
-- Trap Use
function UseFReserve(c)
  return HasID(AIGrave(),24094653,true)
end
-- Frightfur Use
function UseFSabre(c)
  return true
end
function UseFLeo(c)
  OPTSet(c.id)
  return true
end
function UseFTiger(c)
  if #OppField() > 0 then
	return true
  end
end

--39246582, -- Fluffal Dog
--03841833, -- Fluffal Bear
--65331686, -- Fluffal Owl
--98280324, -- Fluffal Sheep
--02729285, -- Fluffal Cat
--38124994, -- Fluffal Rabit
--06142488, -- Fluffal Mouse
--72413000, -- Fluffal Wings
--00006131, -- Fluffal Patchwork (BETA)
--97567736, -- Edge Imp Tomahawk
--61173621, -- Edge Imp Chain
--30068120, -- Edge Imp Sabres
--79109599, -- King of the Swamp
--67441435, -- Glow-Up Bulb

--06077601, -- Frightfur Fusion
--43698897, -- Frightfur Factory
--70245411, -- Toy Vendor
--01845204, -- Instant Fusion
--24094653, -- Polymerization
--43898403, -- Twin Twister

--66127916, -- Fusion Reserve

--80889750, -- Frightfur Sabre-Tooth
--10383554, -- Frightfur Leo
--85545073, -- Frightfur Bear
--11039171, -- Frightfur Wolf
--00464362, -- Frightfur Tiger
--57477163, -- Frightfur Sheep
--41209827, -- Starve Venom Fusion Dragon
--33198837, -- Naturia Beast
--42110604, -- Hi-Speedroid Chanbara
--82633039, -- Castel
--83531441, -- Dante

function FluffalEffectYesNo(id,card) -- FLUFFAL EFFECT YES/NO
  print("EffectYesNo - Cardid: "..card.id.." - desc: "..card.description)
  local result = nil
  if id == 39246582 then -- Dog
	result = 1
  end
  if id == 65331686 then -- Owl
	result = 1
  end
  if id == 02729285 then -- Cat
	result = 1
  end
  if id == 38124994 then -- Rabit
	result = 1
  end
  
  if id == 61173621 then -- Chain
	result = 1
  end
  
  if id == 43698897 then -- Frightfur Factory
	result = 1
  end
  if id == 70245411 then -- ToyVendor
	result = 1
  end
  
  if id == 80889750 then -- Frightfur Sabre-Tooth
	result = 1
  end
  if id == 10383554 then -- Frightfur Leo
	result = 1
  end
  if id == 00464362 then -- Frightfur Tiger
    return UseFTiger(card)
  end
  if id == 57477163 then -- Frightfur Sheep
    return 1
  end
  
  OPTSet(id)
  return result
end

function FluffalYesNo(desc) -- FLUFFAL YES/NO
  print("YesNo: "..desc)
  if desc == 1561083776 then -- Tomahawk Desc 1
    return 1
  end
  if desc == 1561083777 then -- Tomahawk Desc 2
    return 1
  end
  return nil
end
