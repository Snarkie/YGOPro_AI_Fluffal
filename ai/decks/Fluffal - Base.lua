function FluffalStartup(deck)
  print("AI_Fluffal v0.0.0.1 by neftalimich.")
  AI.Chat("¡Duelo!")
  
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
-- FluffalM Count
function CountWingsTarget()
  local result = 0
  result = 1
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
  result = 1
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
  return true
end
function BearCond(loc,c)
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
  return true
end
function OwlCond(loc,c)
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
  return true
end
function SheepCond(loc,c)
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
  return true
end
function CatCond(loc,c)
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
  return true
end
function RabitCond(loc,c)
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
  return true
end
function MouseCond(loc,c)
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
  return true
end
function WingsCond(loc,c)
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
  return true
end
function PatchworkCond(loc,c)
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
  return true
end
-- EdgeImp Cond
function TomahawkCond(loc,c)
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
  return true
end
function ChainCond(loc,c)
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
  return true
end
function SabresCond(loc,c)
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
  return true
end
-- Other Cond
function KoSCond(loc,c)
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
  return true
end
function BulbCond(loc,c)
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
  return true
end
-- FluffalS Cond
function FFusionCond(loc,c)
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
  return true
end
function FFactoryCond(loc,c)
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
  return true
end
function ToyVendorCond(loc,c)
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
  return true
end
-- Spell Cond
function IFusionCond(loc,c)
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
  return true
end
function PolymCond(loc,c)
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
  return true
end
-- Trap Cond
function FReserveCond(loc,c)
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
  return true
end
-- Frightfur Cond
function FSabreCond(loc,c)
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
  return true
end
function FLeoCond(loc,c)
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
  return true
end
function FBearCond(loc,c)
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
  return true
end
function FTigerCond(loc,c)
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
  return true
end
function FSheepCond(loc,c)
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
  return true
end

FluffalPriorityList={
--PRIO_HAND = 1
--PRIO_FIELD = 3
--PRIO_GRAVE = 5
--PRIO_DISCARD = 7
--PRIO_BANISH = 9
 
 [39246582] = {10,1,9,1,1,1,1,1,9,1,DogCond},		-- Fluffal Dog
 [03841833] = {9,1,1,1,1,1,1,1,8,1,BearCond},		-- Fluffal Bear
 [65331686] = {4,1,8,1,1,1,1,1,5,1,OwlCond},		-- Fluffal Owl
 [98280324] = {5,1,1,1,1,1,1,1,6,1,SheepCond},		-- Fluffal Sheep
 [02729285] = {7,1,2,1,1,1,1,1,1,1,CatCond},		-- Fluffal Cat
 [38124994] = {6,1,2,1,1,1,1,1,7,1,RabitCond},		-- Fluffal Rabit
 [06142488] = {1,1,10,1,5,1,5,1,10,1,MouseCond},	-- Fluffal Mouse
 [72413000] = {8,1,1,1,10,1,10,1,1,1,WingsCond},	-- Fluffal Wings
 [00006131] = {1,1,3,1,1,1,1,1,1,1,PatchworkCond},	-- Fluffal Patchwork (BETA)
 [97567736] = {1,1,6,1,8,1,8,1,1,1,TomahawkCond},	-- Edge Imp Tomahawk
 [61173621] = {8,1,5,1,6,1,7,1,1,1,ChainCond},		-- Edge Imp Chain
 [30068120] = {7,1,4,1,7,1,6,1,1,1,SabresCond},		-- Edge Imp Sabres
 [79109599] = {1,1,2,1,1,1,1,1,10,1,KoSCond},		-- King of the Swamp
 [67441435] = {1,1,7,1,9,1,9,1,1,1,BulbCond},		-- Glow-Up Bulb

 [06077601] = {1,1,1,1,1,1,4,1,1,5,FFusionCond},	-- Frightfur Fusion
 [43698897] = {3,1,1,1,1,1,1,1,1,1,FFactoryCond},	-- Frightfur Factory
 [70245411] = {1,1,1,1,1,1,1,2,1,1,ToyVendorCond},	-- Toy Vendor
 [01845204] = {1,1,1,1,1,1,1,1,1,4,IFusionCond},	-- Instant Fusion
 [24094653] = {1,1,1,1,1,1,3,2,1,1,PolymCond},		-- Polymerization
 [43898403] = {1,1,1,1,1,1,1,1,1,1,nil},			-- Twin Twister

 [66127916] = {1,1,1,1,1,1,1,1,1,1,FReserveCond}, 	-- Fusion Reserve
 
 [80889750] = {1,1,6,1,1,1,1,1,1,1,FSabreCond},		-- Frightfur Sabre-Tooth
 [10383554] = {1,1,7,1,1,1,1,1,1,1,FLeoCond},		-- Frightfur Leo
 [85545073] = {5,1,1,1,3,1,1,1,1,1,FBearCond},		-- Frightfur Bear
 [11039171] = {1,1,3,1,1,1,1,1,1,1,FWolfCond},		-- Frightfur Wolf
 [00464362] = {3,1,5,1,5,1,5,1,1,1,FTigerCond},		-- Frightfur Tiger
 [57477163] = {4,1,4,1,4,1,4,1,1,1,FSheepCond},		-- Frightfur Sheep
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
  return OPTCheck(03841833)
end
function SummonOwl()
  return OPTCheck(65331686)
end
function SummonMouse()
  return OPTCheck(06142488)
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
function SpSummonSheep()
  return OPTCheck(98280324)
end
------------------------
--------- USE ----------
------------------------
-- FluffalM Use
function UseBear(c)
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
  OPTSet(c.id)
  return true
end
-- Other Use
function UseKoS(c)
  OPTSet(c.id)
  return true
end
function UseKoS2(c)
  OPTSet(c.id)
  return true
end
-- FluffalS Use
function ActiveToyVendor1(c)
  return FilterPosition(c,POS_FACEDOWN)
end
function ActiveToyVendor2(c)
  return FilterLocation(c,LOCATION_HAND)
end
function UseToyVendor(c)
  if HasID(AIHand(),72413000)
  then
    GlobalToyVendor = 1
	OPTSet(c.cardid)
	return true  
  elseif not NormalSummonCheck() and HasID(AIHand(),39246582) and OPTCheck(72413000) then
	return false
  elseif (#AIHand() > 2 and CountToyVendorDiscardTarget() > 0) then
    GlobalToyVendor = 1
	OPTSet(c.cardid)
	return true
  end
  return false
end

function ActiveFFactory(c)
  return FilterLocation(c,LOCATION_HAND) or FilterPosition(c,POS_FACEDOWN)
end
function UseFFactory(c)
  return true
end

function UseFFusion(c)
  return true
end
-- Spell Use
function UseFFusion(c)
  OPTSet(c.cardid)
  return true
end
function UsePolym(c)
  return true
end
-- Trap Use
function UseFReserve(c)
  return true
end
-- Frightfur Use
function UseFSabre(c)
  return true
end
function UseFLeo(c)
  OPTSet(c.id)
  return true
end
function UseFBear(c)
  return true
end
function UseFTiger(c)
  return true
end
function UseFSheep(c)
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
function FluffalMaterial(cards,willBanish)
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

function FluffalMaterialAdd(cards,min,max)
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
    return Add(cards,PRIO_TOHAND) -- Issue ¿Not working?
  end
  if LocCheck(cards,LOCATION_HAND) then
    print("SheepTarget - HAND to MZONE")
    return Add(cards,PRIO_TOFIELD)
  end
  return Add(cards)
end
function MouseTarget(cards,max)
  return Add(cards,PRIO_TOHAND,max)
end
function WingsTarget(cards)
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
  return Add(cards)
end

function FFractoryTarge(cards,c)
  return Add(cards)
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
  return Add(cards)
end
GlobalPolymerization = nil
function PolymerizationTarget(cards,c)
  if GlobalPolymerization == nil then
	GlobalPolymerization = 1
  end
  if GlobalPolymerization == 1 then
    print("Polymerization - Frightfur Target")
	GlobalPolymerization = 2
    return Add(cards,PRIO_TOFIELD)
  end
  if GlobalPolymerization == 2 then
    print("Polymerization - EdgeImpMaterials")
	GlobalPolymerization = 3
    return Add(cards,PRIO_TOGRAVE)
  end
  if GlobalPolymerization == 3 then
    print("Polymerization - FluffalMaterials")
    return FluffalMaterialAdd(FluffalMaterial(cards,false),1,1)
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
  return Add(cards)
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
  if id == 66127916 then -- FusionReserve
	return FReserveTarget(cards)
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
  if HasIDNotNegated(cards,66127916,ChainFReserve) then
    return 1,CurrentIndex
  end
  return nil
end

function FluffalEffectYesNo(id,card) -- FLUFFAL EFFECT YES/NO
  print("EffectYesNo: "..card.description)
  local result = nil
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