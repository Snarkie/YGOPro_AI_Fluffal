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
    OPTCheck(98280324) and CountEgdeImp(UseLists({AIGrave(),AIHand()})) > 0
end
-- Other
function SpSummonChanbara()
  return true -- Opp Mon max attack < 2200
end
function SpSummonNaturiaBeast()
  return true -- Opp Mon max attack < 2400
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