require("ai.decks.Fluffal.FluffalFilter")
require("ai.decks.Fluffal.FluffalCond")
require("ai.decks.Fluffal.FluffalSummon")
require("ai.decks.Fluffal.FluffalUse")
require("ai.decks.Fluffal.FluffalTarget")
require("ai.decks.Fluffal.FluffalChain")
require("ai.decks.Fluffal.FluffalBattle")

function FluffalStartup(deck)
  print("AI_Fluffal v0.0.0.4.7 by neftalimich.")
  AI.Chat("�Duelo!")
  
  deck.Init                 = FluffalInit
  deck.Card                 = FluffalCard
  deck.Chain                = FluffalChain
  deck.EffectYesNo          = FluffalEffectYesNo
  --deck.YesNo				= FluffalYesNo
  deck.Position             = FluffalPosition
  deck.BattleCommand        = FluffalBattleCommand
  deck.AttackTarget         = FluffalAttackTarget
  deck.AttackBoost			= FluffalAttackBoost
  
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
		--Duel.ConfirmCards(1-player_ai,g)
	end)
	Duel.RegisterEffect(e0,0)
	local e1=e0:Clone()
	e1:SetCode(EVENT_TO_HAND)
	--Duel.RegisterEffect(e1,0)
	local e2=e0:Clone()
	e2:SetCode(EVENT_PHASE_START+PHASE_MAIN1)
	--Duel.RegisterEffect(e2,0)
  local e3=Effect.GlobalEffect()
  e3:SetType(EFFECT_TYPE_FIELD)
  e3:SetCode(EFFECT_PUBLIC)
  e3:SetTargetRange(LOCATION_HAND,0)
  --Duel.RegisterEffect(e3,player_ai)
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

------------------------
--------- COND ---------
------------------------

------------------------
------- SUMMON ---------
------------------------

function FluffalInit(cards) -- FLUFFAL INIT
  local Act = cards.activatable_cards
  local Sum = cards.summonable_cards
  local SpSum = cards.spsummonable_cards
  local Rep = cards.repositionable_cards
  local SetMon = cards.monster_setable_cards
  local SetST = cards.st_setable_cards
  
  --GLOBAL
  GlobalSheep = 0
  GlobalRabit = 0
  GlobalSabres = 0
  GlobalFFusion = 0
  GlobalToyVendor = 0
  GlobalIFusion = 0
  GlobalFusionSummon = 0
  GlobalFusionId = 0
  GlobalCheckPolyTarget = 0
  
  -- ACTIVE EFFECT 1
  if HasIDNotNegated(Act,10383554,UseFLeo) then
    return COMMAND_ACTIVATE,CurrentIndex
  end
  
  if HasIDNotNegated(Act,30068120,UseSabres) then
    GlobalSabres = 1
    return COMMAND_ACTIVATE,CurrentIndex
  end
  
  if HasIDNotNegated(Act,06142488,UseMouse) then
    return COMMAND_ACTIVATE,CurrentIndex
  end
  
  if HasIDNotNegated(Act,97567736,UseTomahawk1,1561083776) then
    return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasIDNotNegated(Act,97567736,UseTomahawk2,1561083777) then
    return COMMAND_ACTIVATE,CurrentIndex
  end
  
  if HasIDNotNegated(Act,98280324,UseSheep) then
    GlobalSheep = 1
    return COMMAND_ACTIVATE,CurrentIndex
  end
  
  if HasIDNotNegated(Act,67441435,UseBulb) then
    return COMMAND_ACTIVATE,CurrentIndex
  end
  
  if HasIDNotNegated(Act,66127916,UseFReserve) then
    return COMMAND_ACTIVATE,CurrentIndex
  end
  
  if HasIDNotNegated(Act,79109599,UseKoS) then
    return COMMAND_ACTIVATE,CurrentIndex
  end
  
  if HasIDNotNegated(Act,03841833,UseBear) then
    return COMMAND_ACTIVATE,CurrentIndex
  end
  
  -- NORMAL SUMMON OWL
  if HasIDNotNegated(Sum,65331686,SummonOwl3) then -- No Poly no wings
    return COMMAND_SUMMON,CurrentIndex
  end
  if HasIDNotNegated(Sum,65331686,SummonOwl2) then
    return COMMAND_SUMMON,CurrentIndex
  end
  
  -- ACTIVE EFFECT 2
  if HasIDNotNegated(Act,70245411,ActiveToyVendor,nil,LOCATION_SZONE,POS_FACEDOWN) then
    return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasIDNotNegated(Act,70245411,UseToyVendor,nil,LOCATION_SZONE,POS_FACEUP) then
    GlobalToyVendor = 1
    return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasIDNotNegated(Act,72413000,UseWings) then
    return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasIDNotNegated(Act,70245411,ActiveToyVendor2,nil,LOCATION_HAND) then
    return COMMAND_ACTIVATE,CurrentIndex
  end
  
  -- NORMAL SUMMON DOG
  if HasIDNotNegated(Sum,39246582,SummonDog) then
    return COMMAND_SUMMON,CurrentIndex
  end
  
  -- ACTIVE EFFECT 3
  if HasIDNotNegated(Act,79109599,UseKoS2) then
	return COMMAND_ACTIVATE,CurrentIndex
  end
  
  -- NORMAL SUMMON 3
  if HasIDNotNegated(Sum,97567736,SummonTomahawk) then
    return COMMAND_SUMMON,CurrentIndex
  end
  if HasIDNotNegated(Sum,06142488,SummonMouse) then
    return COMMAND_SUMMON,CurrentIndex
  end
  if HasIDNotNegated(Sum,00006131,SummonPatchwork) then
    return COMMAND_SUMMON,CurrentIndex
  end
  
  -- SPECIAL SUMMON 1
  if HasIDNotNegated(SpSum,98280324,UseSheep) then
    return COMMAND_SPECIAL_SUMMON,CurrentIndex
  end
  if HasIDNotNegated(SpSum,42110604,SpSummonChanbara) then
    return COMMAND_SPECIAL_SUMMON,CurrentIndex
  end
  
  -- ACTIVE EFFECT FUSION
  if HasIDNotNegated(Act,72413000,UseOwl2) then
    return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasIDNotNegated(Act,01845204,UseIFusion) then
    GlobalIFusion = 1
    return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasIDNotNegated(Act,24094653,UsePolymerization) then -- Polymerization
    GlobalFusionSummon = 1
    return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasIDNotNegated(Act,43698897,UseFFactory) then
    GlobalFusionSummon = 1
    return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasIDNotNegated(Act,43698897,ActiveFFactory) then 
    return COMMAND_ACTIVATE,CurrentIndex
  end
  
  -- ACTIVE EFFECT SHEEP 4
  if HasIDNotNegated(Act,98280324,UseSheep3) then
    GlobalSheep = 1
    return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasIDNotNegated(SpSum,98280324,UseSheep3) then
    return COMMAND_SPECIAL_SUMMON,CurrentIndex
  end
  
  -- ACTIVE EFFECT FUSION 2
  if HasIDNotNegated(Act,06077601,UseFFusion) then 
    GlobalFFusion = 1
    return COMMAND_ACTIVATE,CurrentIndex
  end
  
  -- NORMAL SUMMON EDGE IMP
  if HasIDNotNegated(Sum,61173621,SummonChain) then
    return COMMAND_SUMMON,CurrentIndex
  end
  if HasIDNotNegated(Sum,30068120,SummonSabres) then
    return COMMAND_SUMMON,CurrentIndex
  end
  
  -- ACTIVE EFFECT SHEEP 5
  if HasIDNotNegated(UseLists({AIHand(),AIMon()}),98280324,true) -- Sheep
  and OPTCheck(98280324) and UseSheep2()
  and CountFluffal(AIHand()) > 1 
  then
    for i=1,#Sum do
	  if not(Sum[i].id == 98280324) then
	    return COMMAND_SUMMON,i
	  end
    end
  end
  if HasID(SetST,42110604,SetFReserve) then
    return COMMAND_SET_ST,CurrentIndex
  end
  -- TurnEnd
  if TurnEndCheck() then
    -- ACTIVE EFFECT 
	if HasIDNotNegated(Act,98280324,UseSheep2) then -- Sheep
      GlobalSheep = 1
      return COMMAND_ACTIVATE,CurrentIndex
    end
	if HasIDNotNegated(Act,03841833,UseBear2) then -- Bear
      return COMMAND_ACTIVATE,CurrentIndex
    end
  end
  
  return nil
end

------------------------
--------- USE ----------
------------------------

-----------------------
------- TARGET --------
-----------------------

------------------------
-------- CHAIN ---------
------------------------

------------------------
-------- BATTLE --------
------------------------
