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
function SummonOwl2()
  return OPTCheck(65331686) 
  and not HasID(AIHand(),39246582,true) -- Dog
end
function SummonOwl3()
  return 
    OPTCheck(65331686)
	and not HasID(UseLists({AIHand(),AIST()}),24094653,true) -- Polymerization
	and not HasID(UseLists({AIHand(),AIST()}),43698897,true) -- FFactory
	and not OPTCheck(72413000) -- Wings
end
function SpecialSummonSheep(c)
  if OPTCheck(c.id) 
  and CountEgdeImp(AIGrave()) > 0 
  then
    return true
  else
    return false
  end
end
function SpecialSummonSheep2()
  if OPTCheck(98280324) 
  and CountEgdeImp(UseLists({AIGrave(),AIHand()})) > 0 
  then
    return true
  else
    return false
  end
end
function SpecialSummonSheep3()
  if OPTCheck(98280324) and HasID(AIHand(),97567736,true) then -- Tomahawk
    return true
  else
    return false
  end
end
function SpecialSummonSheep4()
  if OPTCheck(98280324) 
  and CountEgdeImp(UseLists({AIGrave(),AIHand()})) > 0 
  and (
    CountFluffal(AIHand()) - Get_Card_Count_ID(AIHand(),98280324)
  ) > 0
  then
    return true
  else
    return false
  end
end
function SummonMouse()
  return OPTCheck(06142488) 
    and Get_Card_Count_ID(AIDeck(),06142488) == 2
	and #AIMon() < 3
	and HasID(UseLists({AIHand(),AIST()}),24094653,true) -- Polymerization
	and AI.GetPlayerLP(1) > OppGetStrongestAttack()
	and AI.GetPlayerLP(1) >= 2000
end
function SummonPatchwork()
  return 
    CountEgdeImp(UseLists({AIMon(),AIHand()})) == 0
    and HasID(UseLists({AIHand(),AIST()}),24094653,true) -- Polymerization
end
-- EdgeImp Summon
function SummonTomahawk()
  return OPTCheck(97567736)
end
function SummonChain()
  return 
    Duel.GetTurnCount() ~= 1
	and (
	  OppGetStrongestAttack() < AIGetStrongestAttack()
	  or OppGetStrongestAttack() < 1200
	)
end
function SummonSabres()
  return 
    Duel.GetTurnCount() ~= 1
	and (
	  OppGetStrongestAttack() < AIGetStrongestAttack()
	  or OppGetStrongestAttack() < 1200
	)
end

-- Frightfur Fusion Summon
function SpSummonFSabre()
  if (
    HasID(AIMon(),85545073,true) -- Frightfur Bear
	or HasID(AIMon(),00464362,true) -- Frightfur Tiger
	or HasID(AIMon(),57477163,true) -- Frightfur Sheep
  )
  and (
	GlobalMaterialF > 1 -- Fluffal
	or OppGetStrongestAttack() >= AIGetStrongestAttack() -- Strong Opp
  )
  and Duel.GetTurnCount() ~= 1
  then
    return 
	  not HasID(AIMon(),80889750,true) -- Frightfur Sabre-Tooth
	  and AI.GetCurrentPhase() == PHASE_MAIN1
  end
  return false
end
function SpSummonFSabreBanish()
  if CountFrightfur(AIGrave()) > 2 -- Frightfur Grave
  and (
    CountFluffalBanishTarget(UseLists({AIMon(),AIGrave()})) > 0 -- Fluffal
	or OppGetStrongestAttack() >= AIGetStrongestAttack() -- Strong Opp
  )
  and Duel.GetTurnCount() ~= 1
  then
    return 
	  not HasID(AIMon(),80889750,true)
	  and AI.GetCurrentPhase() == PHASE_MAIN1
  end
  return false
end

function FLeoFinish()
  return CardsMatchingFilter(OppMon(),FLeoFinishFilter,c) > 0
end
function SpSummonFLeo()
  if (
    HasID(UseLists({AIMon(),AIHand()}),79109599,true) -- KoS
    or HasID(AIMon(),00006131,true) -- Patchwork
  )
  and GlobalMaterialF > 0 -- Fluffal
  then
    return 
	  not HasID(AIMon(),10383554,true) 
	  and OPTCheck(10383554) 
	  and FLeoFinish()
  end
  return false
end
function SpSummonFLeoBanish()
  if (
    HasID(UseLists({AIMon(),AIGrave()}),79109599,true) -- KoS
    or HasID(AIMon(),00006131,true) -- Patchwork
  )
  and CountFluffalBanishTarget(UseLists({AIMon(),AIGrave()})) > 0
  then
    return 
	  not HasID(AIMon(),10383554,true) 
	  and OPTCheck(10383554) 
	  and FLeoFinish()
  end
  return false
end

function SpSummonFBear()
  return false
end
function SpSummonFBearBanish()
  return false
end

function FWolfFinish()
  return 
    HasID(AIMon(),00464362,true) 
    and #OppMon() == 0
	or
	HasID(AIMon(),80889750,true) 
	and HasID(AIMon(),00464362,true)
	or 
	#OppMon() == 1
	and CardsMatchingFilter(OppST(),FilterPosition,POS_FACEDOWN) == 0
	and HasID(AIMon(),00464362,true)
end
function SpSummonFWolf()
  if (
    HasID(UseLists({AIMon(),AIHand()}),30068120,true) -- Sabres
  )
  and GlobalMaterialF > 0 -- Fluffal
  then
    return 
	  not HasID(AIMon(),11039171,true) 
	  and FWolfFinish()
	  and AI.GetCurrentPhase() == PHASE_MAIN1
	  and GlobalBPAllowed
  end
  return false
end
function SpSummonFWolfBanish()
  if (
    HasID(UseLists({AIMon(),AIGrave()}),30068120,true) -- Sabres
  )
  and CountFluffalBanishTarget(UseLists({AIMon(),AIGrave()})) > 0
  then
    return 
	  not HasID(AIMon(),11039171,true) 
	  and FWolfFinish()
	  and AI.GetCurrentPhase() == PHASE_MAIN1
	  and GlobalBPAllowed
  end
  return false
end

function SpSummonFTiger()
  if (
    HasID(UseLists({AIMon(),AIHand()}),30068120,true) -- Sabres
    or HasID(UseLists({AIMon(),AIHand()}),79109599,true) -- Kos
	or HasID(AIMon(),00006131,true) -- Patchwork
  )
  and GlobalMaterialF > 0 -- Fluffal
  then
    return 
	  not HasID(AIMon(),00464362,true) 
	  and #OppField() > 0
	  and AI.GetCurrentPhase() == PHASE_MAIN1
  end
  return false
end
function SpSummonFTigerBanish()
  if (
    HasID(UseLists({AIMon(),AIGrave()}),30068120,true) -- Sabres
    or HasID(UseLists({AIMon(),AIGrave()}),79109599,true) -- Kos
	or HasID(AIMon(),00006131,true) -- Patchwork
  )
  and CountFluffalBanishTarget(UseLists({AIMon(),AIGrave()})) > 0
  then
    return 
	  not HasID(AIMon(),00464362,true) 
	  and #OppField() > 0
	  and AI.GetCurrentPhase() == PHASE_MAIN1
  end
  return false
end

function SpSummonFSheep()
  if (
    HasID(UseLists({AIMon(),AIHand()}),61173621,true) -- Chain
    or HasID(UseLists({AIMon(),AIHand()}),79109599,true) -- Kos
	or HasID(AIMon(),00006131,true) -- Patchwork
  )
  and GlobalMaterialF > 0 -- Fluffal
  then
    return not HasID(AIMon(),57477163,true)
  end
  return false
end
function SpSummonFSheepBanish()
  if (
    HasID(UseLists({AIMon(),AIGrave()}),61173621,true) -- Chain
    or HasID(UseLists({AIMon(),AIGrave()}),79109599,true) -- Kos
	or HasID(AIMon(),00006131,true) -- Patchwork
  )
  and CountFluffalBanishTarget(UseLists({AIMon(),AIGrave()})) > 0
  then
    return not HasID(AIMon(),57477163,true)
  end
  return false
end

-- Other Fusion
function SpSummonSVFD()
  if (
    CardsMatchingFilter(AIMon(),FilterAttribute,ATTRIBUTE_DARK) > 1 -- Dark
	and CountEgdeImp(AIMon()) > 0
  )
  then
    return not HasID(AIMon(),41209827,true)
  end
  return false
end

-- Other Synchro
function SpSummonChanbara()
  return 
    (OppGetStrongestAttack() < AIGetStrongestAttack()
	or OppGetStrongestAttack() < 2200)
    and AI.GetCurrentPhase() == PHASE_MAIN1
	and GlobalBPAllowed
end
function SpSummonNaturiaBeast()
  return OppGetStrongestAttDef()<=2200
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