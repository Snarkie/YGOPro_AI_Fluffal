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
  return OPTCheck(65331686) and not HasID(AIHand(),39246582,true)
end
function SummonMouse()
  return OPTCheck(06142488) 
    and Get_Card_Count_ID(AIDeck(),06142488) == 2
end
function SummonPatchwork()
  return CountEgdeImp(UseLists({AIMon(),AIHand()})) == 0
end
-- EdgeImp Summon
function SummonTomahawk()
  return OPTCheck(97567736)
end
function SummonChain()
  return OppGetStrongestAttack() < 1200
end
function SummonSabres()
  return OppGetStrongestAttack() < 1200
end

-- Frightfur Special Summon
function SpSummonFSabre()
  if GlobalCheckFusionTarget == 0 -- PreCheck FusionTarget
  or (
    CountFrightfur(AIMon()) > 0 -- Frightfur
	and (
      CountFluffal(UseLists({AIMon(),AIHand()})) > 1 -- Fluffal
	  or OppGetStrongestAttack() >= AIGetStrongestAttack() -- Strong Opp
	)
  )
  then
    return 
	  not HasID(AIMon(),80889750,true)
	  and (
	    Get_Card_Count_ID(AIMon(),85545073) > 0 -- Frightfur Bear
	    or Get_Card_Count_ID(AIMon(),00464362) > 0 -- Frightfur Tiger
	    or Get_Card_Count_ID(AIMon(),57477163) > 0 -- Frightfur Sheep
	  )
  end
  return false
end
function SpSummonFSabreBanish()
  if GlobalCheckFusionTarget == 0 -- PreCheck FusionTarget
  or (
    CountFrightfur(AIMon()) > 0 -- Frightfur
	and (
      CountFluffalBanishTarget(UseLists({AIMon(),AIGrave()})) > 0 -- Fluffal
	  or OppGetStrongestAttack() >= AIGetStrongestAttack() -- Strong Opp
	)
  )
  then
    return 
	  not HasID(AIMon(),80889750,true)
	  and CountFrightfur(AIGrave()) > 1
  end
  return false
end

function FLeoFinish()
  return CardsMatchingFilter(OppMon(),FLeoFinishFilter,c) > 0
end
function SpSummonFLeo()
  if GlobalCheckFusionTarget == 0 -- PreCheck FusionTarget
  or (
    Get_Card_Count_ID(UseLists({AIMon(),AIHand()}),79109599) > 0 -- KoS
	or Get_Card_Count_ID(AIMon(),00006131) > 0 -- Patchwork
  )
  then
    return 
	  not HasID(AIMon(),10383554,true) 
	  and OPTCheck(10383554) 
	  and FLeoFinish()
  end
  return false
end
function SpSummonFLeoBanish()
  if GlobalCheckFusionTarget == 0 -- PreCheck FusionTarget
  or (
    Get_Card_Count_ID(UseLists({AIMon(),AIGrave()}),79109599) > 0 -- KoS
	or Get_Card_Count_ID(AIMon(),00006131) > 0 -- Patchwork
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
  return true
end
function SpSummonFWolf()
  if GlobalCheckFusionTarget == 0 -- PreCheck FusionTarget
  or (
    Get_Card_Count_ID(UseLists({AIMon(),AIHand()}),30068120) > 0 -- Sabres
  )
  then 
    return not HasID(AIMon(),11039171,true)
  end
  return false
end
function SpSummonFWolfBanish()
  if GlobalCheckFusionTarget == 0 -- PreCheck FusionTarget
  or (
    Get_Card_Count_ID(UseLists({AIMon(),AIGrave()}),30068120) > 0 -- Sabres
  )
  and CountFluffalBanishTarget(UseLists({AIMon(),AIGrave()})) > 0
  then 
    return not HasID(AIMon(),11039171,true)
  end
  return false
end

function SpSummonFTiger()
  if GlobalCheckFusionTarget == 0 -- PreCheck FusionTarget
  or (
    Get_Card_Count_ID(UseLists({AIMon(),AIHand()}),30068120) > 0 -- Sabres
    or Get_Card_Count_ID(UseLists({AIMon(),AIHand()}),79109599) > 0 -- Kos
	or Get_Card_Count_ID(AIMon(),00006131) > 0 -- Patchwork
  )
  then 
    return not HasID(AIMon(),00464362,true) and #OppField() > 0
  end
  return false
end
function SpSummonFTigerBanish()
  if GlobalCheckFusionTarget == 0 -- PreCheck FusionTarget
  or (
    Get_Card_Count_ID(UseLists({AIMon(),AIGrave()}),30068120) > 0 -- Sabres
    or Get_Card_Count_ID(UseLists({AIMon(),AIGrave()}),79109599) > 0 -- Kos
	or Get_Card_Count_ID(AIMon(),00006131) > 0 -- Patchwork
  )
  and CountFluffalBanishTarget(UseLists({AIMon(),AIGrave()})) > 0
  then 
    return not HasID(AIMon(),00464362,true) and #OppField() > 0
  end
  return false
end

function SpSummonFSheep()
  if GlobalCheckFusionTarget == 0 -- PreCheck FusionTarget
  or (
    Get_Card_Count_ID(UseLists({AIMon(),AIHand()}),61173621) > 0 -- Chain
    or Get_Card_Count_ID(UseLists({AIMon(),AIHand()}),79109599) > 0 -- Kos
	or Get_Card_Count_ID(AIMon(),00006131) > 0 -- Patchwork
  )
  then 
    return not HasID(AIMon(),57477163,true)
  end
  return false
end
function SpSummonFSheepBanish()
  if GlobalCheckFusionTarget == 0 -- PreCheck FusionTarget
  or (
    Get_Card_Count_ID(UseLists({AIMon(),AIGrave()}),61173621) > 0 -- Chain
    or Get_Card_Count_ID(UseLists({AIMon(),AIGrave()}),79109599) > 0 -- Kos
	or Get_Card_Count_ID(AIMon(),00006131) > 0 -- Patchwork
  )
  and CountFluffalBanishTarget(UseLists({AIMon(),AIGrave()})) > 0
  then 
    return not HasID(AIMon(),57477163,true)
  end
  return false
end

function SpSummonSVFD()
  if GlobalCheckFusionTarget == 0 -- PreCheck FusionTarget
  or (
    CardsMatchingFilter(AIMon(),FilterAttribute,ATTRIBUTE_DARK) > 1 -- Dark
	and CountEgdeImp(AIMon()) > 0
  )
  then 
    return not HasID(AIMon(),41209827,true)
  end
  return false
end


-- Other
function SpSummonChanbara()
  return OppGetStrongestAttDef()<=2000
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