function FluffalStartup(deck)
  print("AI_Fluffal v0.0.0.1 by neftalimich.")
  AI.Chat("�Duelo!")
  
  deck.Init                 = FluffalInit
  deck.Card                 = FluffalCard
  deck.Chain                = FluffalChain
  deck.EffectYesNo          = FluffalEffectYesNo
  deck.YesNo				= FluffalYesNo
  deck.Position             = FluffalPosition
  deck.BattleCommand        = FluffalBattleCommand
  deck.AttackTarget         = FluffalAttackTarget
  
  deck.ActivateBlacklist    = FluffalActivateBlacklist
  deck.SummonBlacklist      = FluffalSummonBlacklist
  deck.SetBlacklist         = FluffalSetBlacklist
  deck.RepositionBlacklist  = FluffalRepoBlacklist
  deck.Unchainable          = FluffalUnchainable
  
  deck.PriorityList         = FluffalPriorityList

  --[[
  Other, more obscure functions, in case you need them. Same as before,
  not defining a function or returning nil causes default logic to take over

  deck.YesNo
  deck.Option
  deck.Sum
  deck.Tribute
  deck.BattleCommand
  deck.AttackTarget
  deck.DeclareCard
  deck.Number
  deck.Attribute
  deck.MonsterType
  ]]
  
  local e0=Effect.GlobalEffect()
	e0:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e0:SetCode(EVENT_CHAIN_SOLVED)
	e0:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		local g=Duel.GetFieldGroup(player_ai,LOCATION_HAND,0)
		Duel.ConfirmCards(1-player_ai,g)
	end)
	Duel.RegisterEffect(e0,0)
	local e1=e0:Clone()
	e1:SetCode(EVENT_TO_HAND)
	Duel.RegisterEffect(e1,0)
	local e2=e0:Clone()
	e2:SetCode(EVENT_PHASE_START+PHASE_MAIN1)
	Duel.RegisterEffect(e2,0)
  local e3=Effect.GlobalEffect()
  e3:SetType(EFFECT_TYPE_FIELD)
  e3:SetCode(EFFECT_PUBLIC)
  e3:SetTargetRange(LOCATION_HAND,0)
  Duel.RegisterEffect(e3,player_ai)
end

FluffalIdentifier = 03841833 -- Bear
DECK_FLUFFAL = NewDeck("Fluffal",FluffalIdentifier,FluffalStartup)

FluffalActivateBlacklist={
-- Blacklist of cards to never activate or chain their effects by the default AI logic
-- Anything you add here should be handled by your script, otherwise the cards will never activate

39246582, -- Fluffal Dog
03841833, -- Fluffal Bear
65331686, -- Fluffal Owl
98280324, -- Fluffal Sheep
02729285, -- Fluffal Cat
38124994, -- Fluffal Rabit
06142488, -- Fluffal Mouse
72413000, -- Fluffal Wings
00006131, -- Fluffal Patchwork (BETA)
97567736, -- Edge Imp Tomahawk
61173621, -- Edge Imp Chain
30068120, -- Edge Imp Sabres
79109599, -- King of the Swamp
67441435, -- Glow-Up Bulb

06077601, -- Frightfur Fusion
43698897, -- Frightfur Factory
70245411, -- Toy Vendor
01845204, -- Instant Fusion
24094653, -- Polymerization
43898403, -- Twin Twister

66127916, -- Fusion Reserve

80889750, -- Frightfur Sabre-Tooth
10383554, -- Frightfur Leo
85545073, -- Frightfur Bear
11039171, -- Frightfur Wolf
00464362, -- Frightfur Tiger
57477163, -- Frightfur Sheep
41209827, -- Starve Venom Fusion Dragon
33198837, -- Naturia Beast
42110604, -- Hi-Speedroid Chanbara
82633039, -- Castel
83531441, -- Dante
}
FluffalSummonBlacklist={
-- Blacklist of cards to never be normal summoned or set by the default AI logic (apparently this includes special summoning?)
39246582, -- Fluffal Dog
03841833, -- Fluffal Bear
65331686, -- Fluffal Owl
98280324, -- Fluffal Sheep
02729285, -- Fluffal Cat
38124994, -- Fluffal Rabit
06142488, -- Fluffal Mouse
72413000, -- Fluffal Wings
00006131, -- Fluffal Patchwork (BETA)
97567736, -- Edge Imp Tomahawk
61173621, -- Edge Imp Chain
30068120, -- Edge Imp Sabres
79109599, -- King of the Swamp
67441435, -- Glow-Up Bulb

80889750, -- Frightfur Sabre-Tooth
10383554, -- Frightfur Leo
85545073, -- Frightfur Bear
11039171, -- Frightfur Wolf
00464362, -- Frightfur Tiger
57477163, -- Frightfur Sheep
41209827, -- Starve Venom Fusion Dragon
33198837, -- Naturia Beast
42110604, -- Hi-Speedroid Chanbara
82633039, -- Castel
83531441, -- Dante
}
FluffalSetBlacklist={
-- Blacklist for cards to never set to the S/T Zone to chain or as a bluff
06077601, -- Frightfur Fusion
43698897, -- Frightfur Factory
70245411, -- Toy Vendor
01845204, -- Instant Fusion
24094653, -- Polymerization
43898403, -- Twin Twister
}
FluffalRepoBlacklist={
-- Blacklist for cards to never be repositioned
98280324, -- Fluffal Sheep
02729285, -- Fluffal Cat
38124994, -- Fluffal Rabit
06142488, -- Fluffal Mouse
72413000, -- Fluffal Wings
00006131, -- Fluffal Patchwork (BETA)
79109599, -- King of the Swamp
67441435, -- Glow-Up Bulb
}
FluffalUnchainable={
-- Blacklist for cards to not chain multiple copies in the same chain
}

------------------------
-------- FILTER --------
------------------------
-- FluffalM Filter
function FluffalFilter(c)
  return IsSetCode(c.setcode,0xa9)
end
-- EdgeImp Filter
function EdgeImpFilter(c)
  return IsSetCode(c.setcode,0xc3)
end
-- Other Filter
-- FluffalS Filter
-- Spell Filter
-- Trap Filter
-- Frightfur Filter

------------------------
-------- COUNT ---------
------------------------
-- General Count 
function CountPrioTarget(cards,loc,p)
  local result = 0
  if p == nil then
    p = 1
  end
  for i=1, #cards do
    local c = cards[i]
	if GetPriority(c,loc) > p then
	  result = result + 1
	end
  end
  return result
end
-- FluffalM Count
function CountWingsTarget()
  local result = 0
  result = CountPrioTarget(AIGrave(),PRIO_BANISH)
  print("CountWingsTarget: "..result)
  return result
end
function CountFluffal(cards)
  return CardsMatchingFilter(cards,FluffalFilter)
end
-- EdgeImp Count
function CountEgdeImp(cards)
  return CardsMatchingFilter(cards,EdgeImpFilter)
end
-- Other
-- FluffalS Count
function CountToyVendorCanUse()
  local result = 0
  local cards = AIST()
  for i=1,#cards do
    if OPTCheck(cards[i].cardid) then
	  result = result + 1
	end
  end
  return result
end
function CountToyVendorDiscardTarget()
  local result = 0
  result = CountPrioTarget(AIHand(),PRIO_TOGRAVE)
  --print("CountToyVendorDiscardTarget: "..result)
  return result
end
-- Spell Count
-- Trap Count
-- Frightfur Count

------------------------
--------- COND ---------
------------------------
-- FluffalM Cond
function DogCond(loc,c)
  if loc == PRIO_TOHAND then
    return OPTCheck(c.id) and not HasID(AIHand(),c.id) and not NormalSummonCheck()
  end
  if loc == PRIO_TOFIELD then
    return OPTCheck(c.id)
  end
  if loc == PRIO_TOGRAVE then
    return not OPTCheck(c.id) or NormalSummonCheck()
  end
  if loc == PRIO_DISCARD then
    return not OPTCheck(c.id) or NormalSummonCheck()
  end
  if loc == PRIO_BANISH then
    return true
  end
  return true
end
function BearCond(loc,c)
  if loc == PRIO_TOHAND then
    if OPTCheck(c.id) and not HasID(AIHand(),c.id)
	and (not HasID(AICards(),70245411) or CountWingsTarget() == 0) then
	  return true
	else
	  return false
	end
  end
  if loc == PRIO_TOFIELD then
    return not OPTCheck(c.id)
  end
  if loc == PRIO_TOGRAVE then
    return not OPTCheck(c.id)
  end
  if loc == PRIO_DISCARD then
    return not OPTCheck(c.id)
  end
  if loc == PRIO_BANISH then
    return true
  end
  return true
end
function OwlCond(loc,c)
  if loc == PRIO_TOHAND then
    return OPTCheck(c.id) and not HasID(AIHand(),c.id) and not NormalSummonCheck()
  end
  if loc == PRIO_TOFIELD then
    return OPTCheck(c.id)
  end
  if loc == PRIO_TOGRAVE then
    return not OPTCheck(c.id)
  end
  if loc == PRIO_DISCARD then
    return not OPTCheck(c.id)
  end
  if loc == PRIO_BANISH then
    return true
  end
  return true
end
function SheepCond(loc,c)
  if loc == PRIO_TOHAND then
    return OPTCheck(c.id) and not HasID(AIHand(),c.id)
  end
  if loc == PRIO_TOFIELD then
    return OPTCheck(c.id)
  end
  if loc == PRIO_TOGRAVE then
    return not OPTCheck(c.id)
  end
  if loc == PRIO_DISCARD then
    return not OPTCheck(c.id)
  end
  if loc == PRIO_BANISH then
    return true
  end
  return true
end
function CatCond(loc,c)
  if GlobalRabit == 1 then
    return 10
  end
  if loc == PRIO_TOHAND then
    return OPTCheck(c.id) and not HasID(AIHand(),c.id) and HasID(AICards(),24094653)
  end
  if loc == PRIO_TOFIELD then
    return true
  end
  if loc == PRIO_TOGRAVE and OPTCheck(c.id) 
  and GlobalPolymerization > 1 then -- Polymerization Material PRIO
    if HasID(AIGrave(),24094653) then 
	  return 10
	else
	  return false
	end
  end
  if loc == PRIO_TOGRAVE then
    return not OPTCheck(c.id)
  end
  if loc == PRIO_DISCARD then
    return not OPTCheck(c.id)
  end
  if loc == PRIO_BANISH then
    return true
  end
  return true
end
function RabitCond(loc,c)
  if loc == PRIO_TOHAND then
    return OPTCheck(c.id) and not HasID(AIHand(),c.id) and HasID(AICards(),24094653)
  end
  if loc == PRIO_TOFIELD then
    return true
  end
  if loc == PRIO_TOGRAVE and OPTCheck(c.id) 
  and GlobalPolymerization > 1 then -- Polymerization Material PRIO
    return 9
  end
  if loc == PRIO_TOGRAVE then
    return not OPTCheck(c.id)
  end
  if loc == PRIO_DISCARD then
    return not OPTCheck(c.id)
  end
  if loc == PRIO_BANISH then
    return true
  end
  return true
end
function MouseCond(loc,c)
  if loc == PRIO_TOHAND then
    return OPTCheck(c.id) and Get_Card_Count_ID(UseLists({AICards(),AIGrave()}),c.id) == 1
  end
  if loc == PRIO_TOFIELD then
    return OPTCheck(c.id)
  end
  if loc == PRIO_TOGRAVE 
  and GlobalPolymerization > 1 then -- Polymerization Material PRIO
    return 8
  end
  if loc == PRIO_TOGRAVE then
    return not OPTCheck(c.id) or Get_Card_Count_ID(UseLists({AICards(),AIGrave()}),c.id) > 1
  end
  if loc == PRIO_DISCARD then
    return not OPTCheck(c.id) or Get_Card_Count_ID(UseLists({AICards(),AIGrave()}),c.id) > 1
  end
  if loc == PRIO_BANISH then
    return true
  end
  return true
end
function WingsCond(loc,c)
  if loc == PRIO_TOHAND then
	if OPTCheck(c.id) and not HasID(UseLists({AIHand(),AIGrave()}),c.id)
	and (
	  HasID(AIHand(),70245411) 
	  or (HasID(AIST(),70245411) and CountToyVendorCanUse() > 0)
	) then
	  return true
	else
	  return false
	end
  end
  if loc == PRIO_TOFIELD then
    return true
  end
  if loc == PRIO_TOGRAVE 
  and GlobalPolymerization > 1 then -- Polymerization Material PRIO
    return 7
  end
  if loc == PRIO_TOGRAVE then
    return true
  end
  if loc == PRIO_DISCARD then
    return true
  end
  if loc == PRIO_BANISH then
    return true
  end
  return true
end
function PatchworkCond(loc,c)
  if loc == PRIO_TOHAND then
    return not HasID(AIHand(),c.id)
  end
  if loc == PRIO_TOFIELD then
    return true
  end
  if loc == PRIO_TOGRAVE 
  and GlobalPolymerization > 1 then -- Polymerization Material PRIO
    return 7
  end
  if loc == PRIO_TOGRAVE then
    return true
  end
  if loc == PRIO_DISCARD then
    return true
  end
  if loc == PRIO_BANISH then
    return true
  end
  return true
end
-- EdgeImp Cond
function TomahawkCond(loc,c)
  if loc == PRIO_TOHAND then
    return OPTCheck(c.id) and not HasID(AIHand(),c.id)
  end
  if loc == PRIO_TOFIELD then
    return OPTCheck(c.id)
  end
  if loc == PRIO_TOGRAVE 
  and GlobalPolymerization > 1 then -- Polymerization Material PRIO
    return 8
  end
  if loc == PRIO_TOGRAVE then
    return true
  end
  if loc == PRIO_DISCARD then
    return true
  end
  if loc == PRIO_BANISH then
    return true
  end
  return true
end
function ChainCond(loc,c)
  if loc == PRIO_TOHAND then
    return OPTCheck(c.id) and not HasID(AIHand(),c.id) and not NormalSummonCheck()
  end
  if loc == PRIO_TOFIELD then
    if FilterLocation(c,LOCATION_GRAVE) then
      return GetPriority(c,loc) + 10
	else
	  return OPTCheck(c.id)
	end
  end
  if loc == PRIO_TOGRAVE then
    return OPTCheck(c.id)
  end
  if loc == PRIO_DISCARD then
    return OPTCheck(c.id)
  end
  if loc == PRIO_BANISH then
    return true
  end
  return true
end
function SabresCond(loc,c)
  if loc == PRIO_TOHAND then
    return not HasID(AIHand(),c.id)
  end
  if loc == PRIO_TOFIELD then
    if FilterLocation(c,LOCATION_GRAVE) then
      return GetPriority(c,loc) + 10
	else
	  return true
	end
  end
  if loc == PRIO_TOGRAVE then
    return true
  end
  if loc == PRIO_DISCARD then
    return true
  end
  if loc == PRIO_BANISH then
    return true
  end
  return true
end
-- Other Cond
function KoSCond(loc,c)
  if loc == PRIO_TOHAND then
    return OPTCheck(c.id) and not HasID(AIHand(),c.id)
  end
  if loc == PRIO_TOFIELD then
    if FilterLocation(c,LOCATION_GRAVE) then
      return GetPriority(c,loc) + 10
	else
	  return true
	end
  end
  if loc == PRIO_TOGRAVE 
  and GlobalPolymerization > 1 then -- Polymerization Material PRIO
    return 9
  end
  if loc == PRIO_TOGRAVE then
    return not OPTCheck(c.id)
  end
  if loc == PRIO_DISCARD then
    return not OPTCheck(c.id)
  end
  if loc == PRIO_BANISH then
    return true
  end
  return true
end
function BulbCond(loc,c)
  if loc == PRIO_TOHAND then
    return not HasID(AIHand(),c.id)
  end
  if loc == PRIO_TOFIELD then
    return Get_Card_Count_Level(AIMon(),4,"==") > 0
  end
  if loc == PRIO_TOGRAVE then
    return true
  end
  if loc == PRIO_DISCARD then
    return true
  end
  if loc == PRIO_BANISH then
    return true
  end
  return true
end
-- FluffalS Cond
function FFusionCond(loc,c)
  if loc == PRIO_TOHAND then
    return OPTCheck(c.id) and not HasID(AIHand(),c.id)
  end
  if loc == PRIO_TOGRAVE then
    return not OPTCheck(c.id) or Get_Card_Count_ID(AICards(),c.id) > 1
  end
  if loc == PRIO_DISCARD then
    return not OPTCheck(c.id) or Get_Card_Count_ID(AICards(),c.id) > 1
  end
  if loc == PRIO_BANISH then
    return true
  end
  return true
end
function FFactoryCond(loc,c)
  if loc == PRIO_TOHAND then
    return OPTCheck(c.id)and not HasID(AIHand(),c.id)
  end
  if loc == PRIO_TOGRAVE then
    return not OPTCheck(c.id)
  end
  if loc == PRIO_DISCARD then
    return not OPTCheck(c.id)
  end
  if loc == PRIO_BANISH then
    return true
  end
  return true
end
function ToyVendorCond(loc,c)
  if loc == PRIO_TOHAND then
    return not HasID(AIHand(),c.id)
  end
  if loc == PRIO_TOGRAVE then
    return OPTCheck(c.cardid)
  end
  if loc == PRIO_DISCARD then
    return true
  end
  if loc == PRIO_BANISH then
    return true
  end
  return true
end
-- Spell Cond
function IFusionCond(loc,c)
  if loc == PRIO_TOHAND then
    return OPTCheck(c.id) and not HasID(AIHand(),c.id)
  end
  if loc == PRIO_TOGRAVE then
    return not OPTCheck(c.id)
  end
  if loc == PRIO_DISCARD then
    return not OPTCheck(c.id)
  end
  if loc == PRIO_BANISH then
    return true
  end
  return true
end
function PolymCond(loc,c)
  if loc == PRIO_TOHAND then
    return not HasID(AIHand(),c.id) 
  end
  if loc == PRIO_TOGRAVE then
    return true
  end
  if loc == PRIO_DISCARD then
    return Get_Card_Count_ID(AICards(),c.id) > 1
  end
  if loc == PRIO_BANISH then
    return true
  end
  return true
end
-- Trap Cond
function FReserveCond(loc,c)
  return true
end
-- Frightfur Cond
function FSabreCond(loc,c)
  if loc == PRIO_TOHAND then
    return true
  end
  if loc == PRIO_TOFIELD then
    return not HasID(AIMon(),c.id) and CountFluffal(IACards()) > 1
  end
  if loc == PRIO_TOGRAVE then
    return true
  end
  if loc == PRIO_EXTRA then
    return true
  end
  if loc == PRIO_BANISH then
    return true
  end
  return true
end
function FLeoCanFinish()
  return true
end
function FLeoCond(loc,c)
  if loc == PRIO_TOHAND then
    return OPTCheck(c.id)
  end
  if loc == PRIO_TOFIELD then
    return OPTCheck(c.id) and FLeoCanFinish()
  end
  if loc == PRIO_TOGRAVE then
    return not OPTCheck(c.id)
  end
  if loc == PRIO_EXTRA then
    return not OPTCheck(c.id)
  end
  if loc == PRIO_BANISH then
    return not OPTCheck(c.id)
  end
  return true
end
function FBearCond(loc,c)
  if loc == PRIO_TOHAND then
    return OPTCheck(03841833) or not HasID(AIHand(),03841833) -- Bear
  end
  if loc == PRIO_TOFIELD then
    return OPTCheck(c.id)
  end
  if loc == PRIO_TOGRAVE then
    return not OPTCheck(c.id)
  end
  if loc == PRIO_DISCARD then
    return not OPTCheck(c.id)
  end
  if loc == PRIO_BANISH then
    return true
  end
  return true
end
function FWolfCond(loc,c)
  if loc == PRIO_TOHAND then
    return OPTCheck(c.id)
  end
  if loc == PRIO_TOFIELD then
    return OPTCheck(c.id)
  end
  if loc == PRIO_TOGRAVE then
    return not OPTCheck(c.id)
  end
  if loc == PRIO_DISCARD then
    return not OPTCheck(c.id)
  end
  if loc == PRIO_BANISH then
    return true
  end
  return true
end
function FTigerCond(loc,c)
  if loc == PRIO_TOHAND then
    return not HasID(AIHand(),30068120) -- Sabres
  end
  if loc == PRIO_TOFIELD then
    return OPTCheck(c.id)
  end
  if loc == PRIO_TOGRAVE then
    return not OPTCheck(c.id)
  end
  if loc == PRIO_DISCARD then
    return not OPTCheck(c.id)
  end
  if loc == PRIO_BANISH then
    return true
  end
  return true
end
function FSheepCond(loc,c)
  if loc == PRIO_TOHAND then
    return OPTCheck(c.id)
  end
  if loc == PRIO_TOFIELD then
    return OPTCheck(c.id)
  end
  if GlobalIFusion == 1 then
    return 10 -- Instant Fusion PRIO
  end
  if loc == PRIO_TOGRAVE then
    return not OPTCheck(c.id)
  end
  if loc == PRIO_DISCARD then
    return not OPTCheck(c.id)
  end
  if loc == PRIO_BANISH then
    return true
  end
  return true
end

FluffalPriorityList={
--PRIO_TOHAND = 1
--PRIO_TOFIELD = 3
--PRIO_TOGRAVE = 5
--PRIO_DISCARD = 7
--PRIO_BANISH = 9
 
 [39246582] = {10,1,9,1,2,1,1,1,9,1,DogCond},		-- Fluffal Dog
 [03841833] = {9,1,1,1,1,1,1,1,8,1,BearCond},		-- Fluffal Bear
 [65331686] = {4,1,8,1,1,1,1,1,5,1,OwlCond},		-- Fluffal Owl
 [98280324] = {5,1,1,1,1,1,1,1,6,1,SheepCond},		-- Fluffal Sheep
 [02729285] = {7,1,2,1,1,1,1,1,2,1,CatCond},		-- Fluffal Cat
 [38124994] = {6,1,2,1,1,1,1,1,7,1,RabitCond},		-- Fluffal Rabit
 [06142488] = {1,1,10,1,5,1,5,1,10,1,MouseCond},	-- Fluffal Mouse
 [72413000] = {8,1,1,1,10,1,10,1,1,1,WingsCond},	-- Fluffal Wings
 [00006131] = {1,1,3,1,1,1,1,1,2,1,PatchworkCond},	-- Fluffal Patchwork (BETA)
 [97567736] = {1,1,6,1,8,1,8,1,6,1,TomahawkCond},	-- Edge Imp Tomahawk
 [61173621] = {8,1,5,1,6,1,7,1,4,1,ChainCond},		-- Edge Imp Chain
 [30068120] = {7,1,4,1,7,1,6,1,5,1,SabresCond},		-- Edge Imp Sabres
 [79109599] = {1,1,2,1,1,1,1,1,10,1,KoSCond},		-- King of the Swamp
 [67441435] = {1,1,7,1,9,1,9,1,1,1,BulbCond},		-- Glow-Up Bulb

 [06077601] = {1,1,1,1,1,1,4,1,10,1,FFusionCond},	-- Frightfur Fusion
 [43698897] = {3,1,1,1,1,1,1,1,1,1,FFactoryCond},	-- Frightfur Factory
 [70245411] = {1,1,1,1,1,2,1,2,1,1,ToyVendorCond},	-- Toy Vendor
 [01845204] = {1,1,1,1,3,2,3,2,4,1,IFusionCond},	-- Instant Fusion
 [24094653] = {1,1,1,1,1,1,3,2,3,1,PolymCond},		-- Polymerization
 [43898403] = {1,1,1,1,1,1,1,1,1,1,nil},			-- Twin Twister

 [66127916] = {1,1,1,1,1,1,1,1,1,1,FReserveCond}, 	-- Fusion Reserve
 
 [80889750] = {1,1,6,1,1,1,1,1,4,1,FSabreCond},		-- Frightfur Sabre-Tooth
 [10383554] = {1,1,7,1,2,1,1,1,10,1,FLeoCond},		-- Frightfur Leo
 [85545073] = {5,1,1,1,3,1,1,1,2,1,FBearCond},		-- Frightfur Bear
 [11039171] = {1,1,3,1,2,1,1,1,9,1,FWolfCond},		-- Frightfur Wolf
 [00464362] = {3,1,5,1,5,1,1,1,3,1,FTigerCond},		-- Frightfur Tiger
 [57477163] = {4,1,4,1,4,1,1,1,1,1,FSheepCond},		-- Frightfur Sheep
 [41209827] = {1,1,1,1,1,1,1,1,1,1,nil}, 			-- Starve Venom Fusion Dragon<
 [33198837] = {1,1,1,1,1,1,1,1,1,1,nil}, 			-- Naturia Beast
 [42110604] = {1,1,1,1,1,1,1,1,1,1,nil}, 			-- Hi-Speedroid Chanbara
 [82633039] = {1,1,1,1,1,1,1,1,1,1,nil}, 			-- Castel
 [83531441] = {1,1,1,1,1,1,1,1,1,1,nil}, 			-- Dante
}
------------------------
------- SUMMON ---------
------------------------
-- FluffalM Normal Summon
function SummonDog()
  return OPTCheck(39246582)
end
function SummonBear()
  return not OPTCheck(03841833)
end
function SummonOwl()
  return OPTCheck(65331686)
end
function SummonMouse()
  return OPTCheck(06142488) 
    and Get_Card_Count_ID(AIDeck(),06142488) == 2
end
function SummonPatchwork()
  return CountEgdeImp(IACards())
end
-- EdgeImp Summon
function SummonTomahawk()
  return OPTCheck(97567736)
end
function SummonChain()
  return true
end
function SummonSabres()
  return true
end
-- FluffalM Special Summon
function SpSummonSheep1()
  return OPTCheck(98280324) and CountEgdeImp(AIGrave()) > 0
end
function SpSummonSheep2()
  return 
    OPTCheck(98280324) and (CountEgdeImp(AIHand()) + CountEgdeImp(AIGrave())) > 0
end
------------------------
--------- USE ----------
------------------------
-- FluffalM Use
function UseBear(c)
  if CountToyVendorDiscardTarget() > 0 then
    OPTSet(c.id)
    return true
  else
    return false
  end
end
function UseSheep(c)
  OPTSet(c.id)
  return true
end
function UseMouse(c)
  OPTSet(c.id)
  return true
end
function UseWings(c)
  if CountWingsTarget() > 0 then
    OPTSet(c.id)
	return true
  else
    return false
  end
end
-- EdgeImp Use
function UseTomahawk(c)
  print("Tomahawk Description: "..c.description)
  return true
end
function UseSabres(c)
  if false then
    OPTSet(c.id)
    return true
  else
	return false
  end
end
-- Other Use
function UseKoS(c)
  if not HasID(AICards(),24094653) then -- Polymerization
    OPTSet(c.id)
    return true
  else
    return false
  end
end
function UseKoS2(c)
  if CountToyVendorDiscardTarget() < 1 then
    OPTSet(c.id)
    return true
  else
    return false
  end
end
-- FluffalS Use
function ActiveToyVendor1(c)
  return FilterPosition(c,POS_FACEDOWN)
end
function ActiveToyVendor2(c)
  return FilterLocation(c,LOCATION_HAND)
end
function UseToyVendor(c)
  if HasID(AIHand(),72413000) then
    GlobalToyVendor = 1
	OPTSet(c.cardid)
	return true  
  elseif not NormalSummonCheck() and HasID(AIHand(),39246582) and OPTCheck(72413000) then
	return false
  elseif (#AIHand() > 2 and CountToyVendorDiscardTarget() > 0) then
    GlobalToyVendor = 1
	OPTSet(c.cardid)
	return true
  else
    return false
  end
end

function ActiveFFactory(c)
  if FilterLocation(c,LOCATION_HAND) or FilterPosition(c,POS_FACEDOWN) then
    return 
	  HasID(AIGrave(),06077601) -- Frightfur Fusion
      or HasID(AIGrave(),01845204) -- Instant Fusion
  else
    return false
  end
end
function UseFFactory(c)
  if FilterLocation(c,LOCATION_SZONE) then
    return true
  end
end

function UseFFusion(c)
  OPTSet(c.id)
  return true
end
-- Spell Use
function UseIFusion(c)
  if HasID(AICards(),24094653) -- Polymerization
  and not HasID(AIMon(),80889750) then -- Sabre-Tooth
    OPTSet(c.id)
    return true
  else
    return false
  end
end
function UsePolym(c)
  return true
end
-- Trap Use
function UseFReserve(c)
  return HasID(AIGrave(),24094653)
end
-- Frightfur Use
function UseFSabre(c)
  return true
end
function UseFLeo(c)
  OPTSet(c.id)
  return true
end
------------------------
--------- SET ----------
------------------------
-- FluffalM Set
-- EdgeImp Set
function SetChain(c)
  return true
end
function SetSabres(c)
  return true
end
-- Other Set
-- FluffalS Set
-- Spell Set
-- Trap Set
function SetFReserve(c)
  return true
end
-- Frightfur Set

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


function FluffalInit(cards) -- FLUFFAL INIT
  local Act = cards.activatable_cards
  local Sum = cards.summonable_cards
  local SpSum = cards.spsummonable_cards
  local Rep = cards.repositionable_cards
  local SetMon = cards.monster_setable_cards
  local SetST = cards.st_setable_cards
 
  --GLOBAL
  GlobalRabit = nil
  GlobalFFusion = nil
  GlobalToyVendor = nil
  GlobalIFusion = nil
  GlobalPolymerization = nil
  
  -- SETS
  if HasID(SetST,66127916,SetFReserve) then --FusionReserve
    return COMMAND_SET_ST,CurrentIndex
  end
  return nil
end

-----------------------
------- TARGET --------
-----------------------
-- Frightfur Materials
function FluffalMaterial(cards,willBanish) -- Obsoleto?
  print("FluffalMaterials: "..#cards)
  local result = {}
  for i=1, #cards do
    local c = cards[i]
	local p = 20
	c.prio = 1
	c.indexT = i
	result[#result + 1] = c
  end
  print("FluffalMaterials - Count: "..#result)
  table.sort(result,function(a,b)return a.prio>b.prio end)
  return result
end

function FluffalMaterialAdd(cards,min,max) -- Obsoleto?
  local result = {}
  for i=1,max do
    local c = cards[i]
	result[#result+1] = c.indexT
  end
  --print("FluffalMaterialsAdd - Result: "..#result)
  return result
end
-- FluffalM Target
function DogTarget(cards)
  if LocCheck(cards,LOCATION_DECK) then
	return Add(cards,PRIO_TOHAND)
  end
  return Add(cards)
end
function SheepTarget(cards)
  if LocCheck(cards,LOCATION_MZONE) then
    print("SheepTarget - MZONE to HAND")
    return Add(cards,PRIO_TOHAND)
  else 
	print("SheepTarget - Hand/Grave to MZONE")
    return Add(cards,PRIO_TOFIELD)
  end
  return Add(cards)
end
GlobalRabit = nil
function RabitTarget(cards)
  GlobalRabit = 1
  return Add(cards,PRIO_HAND)
end
function MouseTarget(cards,max)
  return Add(cards,PRIO_TOFIELD,max)
end
function WingsTarget(cards)
  if LocCheck(cards,LOCATION_GRAVE) then
    print("WingsTarget - Grave to Banish")
	return Add(cards,PRIO_BANISH)
  end
  if LocCheck(cards,LOCATION_SZONE) then
    print("WingsTarget - SZone to Grave")
    return Add(cards,PRIO_GRAVE)
  end
  return Add(cards,PRIO_BANISH)
end
-- EdgeImp Target
function TomahawkTarget(cards)
  if LocCheck(cards,LOCATION_DECK) then
    return Add(cards,PRIO_TOGRAVE)
  end
  if LocCheck(cards,LOCATION_HAND) then
    return Add(cards,PRIO_DISCARD)
  end
  return Add(cards)
end
function ChainTarget(cards)
  return Add(cards,PRIO_TOHAND)
end
function SabresTarget(cards)
  return Add(cards,PRIO_DISCARD)
end
-- Other Target
-- FluffalS Target
GlobalFFusion = nil
function FFusionTarget(cards,c)
  if GlobalFFusion == nil then
    GlobalFFusion = 1
  end
  if GlobalFFusion == 1 then
    GlobalFFusion = 2
    return Add(cards,PRIO_TOFIELD)
  end
  if GlobalFFusion == 2 then
    return Add(cards,PRIO_BANISH,min)
  end
  return Add(cards)
end

function FFactoryTarget(cards,c)
  if LocCheck(cards,LOCATION_GRAVE) then
    return Add(cards,PRIO_BANISH)
  end
  if LocCheck(cards,LOCATION_EXTRA) then
    return Add(cards,PRIO_TOFIELD)
  else
    GlobalPolymerization = 3
    return Add(cards,PRIO_TOGRAVE)
  end
end

GlobalToyVendor = nil
function ToyVendorTarget(cards,c)
  if FilterLocation(c,LOCATION_SZONE) then
    if GlobalToyVendor == nil then
	  GlobalToyVendor = 1
	end
    if LocCheck(cards,LOCATION_HAND) and GlobalToyVendor == 1 then
	  print("ToyVendor - Hand To Grave")
	  GlobalToyVendor = 2
      return Add(cards,PRIO_DISCARD)
    end
	if LocCheck(cards,LOCATION_HAND) and GlobalToyVendor == 2 then
	  print("ToyVendor - Hand To Field")
	  return Add(cards,PRIO_TOFIELD)
	end
  end
  if LocCheck(cards,LOCATION_DECK) then
    return Add(cards,PRIO_TOHAND)
  end
  return Add(cards)
end
-- Spell Target
function IFusionTarget(cards,c)
  return Add(cards,PRIO_TOFIELD)
end
GlobalPolymerization = nil
GlobalFusionId = nil
function PolymerizationTarget(cards,c)
  if GlobalPolymerization == nil then
	GlobalPolymerization = 1
  end
  if GlobalPolymerization == 1 then
    GlobalFusionId = cards[Add(cards,PRIO_TOFIELD)[1]].id
	GlobalPolymerization = 2
    print("Polymerization - Fusion Target: "..GlobalFusionId)
    return Add(cards,PRIO_TOFIELD)
  end
  if GlobalPolymerization == 2 then
    print("Polymerization - FirstMaterial: "..cards[Add(cards,PRIO_TOGRAVE)[1]].id)
	GlobalPolymerization = 3
    return Add(cards,PRIO_TOGRAVE)
  end
  if GlobalPolymerization == 3 then
    print("Polymerization - SecondMaterial: "..cards[Add(cards,PRIO_TOGRAVE)[1]].id)
    --return FluffalMaterialAdd(FluffalMaterial(cards,false),1,1)
	if GlobalFusionId == 80889750 then
	  return Add(cards,PRIO_TOGRAVE,2)
	end
	return Add(cards,PRIO_TOGRAVE,1) -- Trick with GlobalPolymerization
  end
end
-- Trap Target
function FReserveTarget(cards,c)
  if LocCheck(cards,LOCATION_EXTRA) then
    return Add(cards,PRIO_TOHAND)
  end
  if LocCheck(cards,LOCATION_DECK) then
    return Add(cards,PRIO_TOHAND)
  end
  return Add(cards)
end
-- Frightfur Target

function FSabreTarget(cards,c)
  return Add(cards,PRIO_TOFIELD)
end
function FLeoTarget(cards,c)
  return Add(cards)
end
function FTigerTarget(cards,c)
  return Add(cards)
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

function FluffalCard(cards,min,max,id,c) -- FLUFFAL CARDS
  print("FluffalCard: "..c.id)
  if id == 39246582 then -- Dog
    return DogTarget(cards)
  end
  if id == 98280324 then -- Sheep
    return SheepTarget(cards)
  end
  if id == 38124994 then -- Rabit
    return RabitTarget(cards)
  end
  if id == 06142488 then -- Mouse
    return MouseTarget(cards,max)
  end
  if id == 72413000 then -- Wings
    return WingsTarget(cards)
  end
  
  if id == 97567736 then -- Tomahawk
    return TomahawkTarget(cards)
  end
  if id == 61173621 then -- Chain
    return ChainTarget(cards)
  end
  if id == 30068120 then -- Sabres
    return SabresTarget(cards)
  end
  
  if id == 06077601 then -- Frightfur Fusion
	return FFusionTarget(cards,c,min)
  end
  if id == 43698897 then -- Frightfur Factory
	return FFactoryTarget(cards,c)
  end
  if id == 70245411 then -- Toy Vendor
	return ToyVendorTarget(cards,c)
  end
  
  if id == 01845204 then -- Instant Fusion
	return PolymerizationTarget(cards,c)
  end
  if id == 24094653 then -- Polymerization
	return PolymerizationTarget(cards,c)
  end

  if id == 66127916 then -- FusionReserve
	return FReserveTarget(cards)
  end
  
  if id == 80889750 then -- Frightfur Sabre-Tooth
	return FSabreTarget(cards)
  end
  if id == 10383554 then -- Frightfur Leo
	return FLeoTarget(cards)
  end
  if id == 00464362 then -- Frightfur Tiger
	return FTigerTarget(cards)
  end
  return nil
end

------------------------
-------- CHAIN ---------
------------------------
-- FluffalM Chain
function ChainDog(c)
  return true
end
function ChainOwl(c)
  return true
end
function ChainCat(c)
  return true
end
function ChainRabit(c)
  return true
end
-- EdgeImp Chain
function ChainChain(c)
  return true
end
-- Other Chain
-- FluffalS Chain
-- Spell Chain
-- Trap Chain
function ChainFReserve(c)
  if FilterLocation(c,LOCATION_SZONE) then
    if RemovalCheckCard(c) then
	  if (RemovalCheckCard(c,CATEGORY_TOGRAVE) or RemovalCheckCard(c,CATEGORY_DESTROY)) then
	    return true
	  end
	end
  end
  return false
end
-- Frightfur Chain

function FluffalChain(cards) -- FLUFFAL CHAINS
  --print("FluffalChain")
  if HasIDNotNegated(cards,39246582,ChainDog) then -- Dog
    return 1,CurrentIndex
  end
  if HasIDNotNegated(cards,65331686,ChainOwl) then -- Owl
    return 1,CurrentIndex
  end
  if HasIDNotNegated(cards,02729285,ChainCat) then -- Cat
    return 1,CurrentIndex
  end
  if HasIDNotNegated(cards,38124994,ChainRabit) then -- Rabit
    return 1,CurrentIndex
  end
  
  if HasIDNotNegated(cards,66127916,ChainFReserve) then -- FusionReserve
    return 1,CurrentIndex
  end
  return nil
end

function FluffalEffectYesNo(id,card) -- FLUFFAL EFFECT YES/NO
  print("EffectYesNo: "..card.description)
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
  
  if id == 97567736 and UseTomahawk(card) then -- Tomahawk
	result = 1
  end
  if id == 61173621 then -- Chain
	result = 1
  end
  
  if id == 70245411 then -- ToyVendor
	result = 1
  end
  
  if id == 80889750 then -- Sabre-Tooth
	result = 1
  end
  
  if id == 66127916 and ChainFReserve(card) then -- FusionReserve
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


FluffalAtt={
39246582, -- Fluffal Dog
03841833, -- Fluffal Bear
97567736, -- Edge Imp Tomahawk

80889750, -- Frightfur Sabre-Tooth
10383554, -- Frightfur Leo
85545073, -- Frightfur Bear
11039171, -- Frightfur Wolf
00464362, -- Frightfur Tiger
57477163, -- Frightfur Sheep
41209827, -- Starve Venom Fusion Dragon
33198837, -- Naturia Beast
42110604, -- Hi-Speedroid Chanbara
82633039, -- Castel
}

FluffalDef={
65331686, -- Fluffal Owl
98280324, -- Fluffal Sheep
02729285, -- Fluffal Cat
38124994, -- Fluffal Rabit
06142488, -- Fluffal Mouse
72413000, -- Fluffal Wings
00006131, -- Fluffal Patchwork (BETA)

61173621, -- Edge Imp Chain
30068120, -- Edge Imp Sabres
79109599, -- King of the Swamp
67441435, -- Glow-Up Bulb

83531441, -- Dante
}

function FluffalPosition(id,available) -- FLUFFAL POSITION
  print("FluffalPosition: "..id)
  local result
  for i=1,#FluffalAtt do
    if FluffalAtt[i]==id
    then
      result=POS_FACEUP_ATTACK
    end
  end
  for i=1,#FluffalDef do
    if FluffalDef[i]==id
    then
      result=POS_FACEUP_DEFENCE
    end
  end
 return result
end

function FluffalAttackTarget(cards,attacker) -- FLUFFAL ATTACK TARGET
  local id = attacker.id
  local result ={attacker}
  ApplyATKBoosts(result)
  ApplyATKBoosts(cards)
  result = {}
  local atk = attacker.attack
 return nil
end

function FluffalBattleCommand(cards,activatable) --FLUFFAL BATTLE COMMAND
  ApplyATKBoosts(cards)
  for i=1,#cards do
    cards[i].index = i
  end
  -- check for monsters, that cannot be attacked, or have to be attacked first.
  local targets = OppMon()
  local attackable = {}
  local mustattack = {}
  local lightning = {}
  for i=1,#targets do
    if targets[i]:is_affected_by(EFFECT_CANNOT_BE_BATTLE_TARGET)==0 then
      attackable[#attackable+1]=targets[i]
    end
    if targets[i]:is_affected_by(EFFECT_MUST_BE_ATTACKED)>0 then
      mustattack[#mustattack+1]=targets[i]
    end
	if targets[i].attack == LightningMonitorAttack
    and bit32.band(targets[i].position,POS_ATTACK)>0 then
	  lightning[#lightning+1]=targets[i]
	end
  end
  if #mustattack>0 then
    targets = mustattack
  elseif DoubleUtopiaActivated then
    targets = lightning
  else
    targets = attackable
  end
  ApplyATKBoosts(targets)
 return nil
end