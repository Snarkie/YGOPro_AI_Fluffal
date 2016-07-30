------------------------
--------- COND ---------
------------------------
-- FluffalM cond
function DogCond(loc,c)
  if GlobalSheep == 1 then
    return 9
  end
  if loc == PRIO_TOHAND then
    return OPTCheck(c.id) and not HasID(AIHand(),c.id,true) and not NormalSummonCheck()
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
    return not OPTCheck(c.id)
  end
  return true
end
function BearCond(loc,c)
  if loc == PRIO_TOHAND then
    return 
	  OPTCheck(c.id) 
	  and not HasID(AIHand(),c.id,true)
	  and not HasID(UseLists({AIHand(),AIST()}),70245411,true)
	  and OPTCheck(72413000)
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
    return not OPTCheck(c.id)
  end
  return true
end
function OwlCond(loc,c)
  if GlobalSheep == 1 then
    return 10
  end
  if loc == PRIO_TOHAND then
    return OPTCheck(c.id) and not HasID(AIHand(),c.id,true)
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
    return not OPTCheck(c.id)
  end
  return true
end
function SheepCond(loc,c)
  if loc == PRIO_TOHAND then
    return OPTCheck(c.id) and not HasID(AIHand(),c.id,true)
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
    return not OPTCheck(c.id)
  end
  return true
end
function CatCond(loc,c)
  if GlobalRabit == 1 then
    return 10
  end
  if loc == PRIO_TOHAND then
    return 
	  OPTCheck(c.id) and not HasID(AIHand(),c.id,true) -- Cat
	  and Get_Card_Count_ID(UseLists({AIST(),AIHand()}),24094653) > 0 -- Polymerization
  end
  if loc == PRIO_TOFIELD then
    return OPTCheck(c.id)
  end
  if GlobalFusionSummon > 0 then
    if OPTCheck(c.id) then
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
    return not OPTCheck(c.id)
  end
  return true
end
function RabitCond(loc,c)
  if loc == PRIO_TOHAND then
    return 
	  OPTCheck(c.id) and not HasID(AIHand(),c.id,true) -- Rabit
	  and Get_Card_Count_ID(UseLists({AIST(),AIHand()}),24094653) > 0 -- Polymerization
  end
  if loc == PRIO_TOFIELD then
    return OPTCheck(c.id)
  end
  if GlobalFusionSummon > 0 then
    if OPTCheck(c.id) then
	  return 9
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
    return not OPTCheck(c.id)
  end
  return true
end
function MouseCond(loc,c)
  if loc == PRIO_TOHAND then
    return 
	  OPTCheck(c.id) and not HasID(AIHand(),c.id,true) -- Mouse
	  and Get_Card_Count_ID(AIDeck(),c.id) == 2 -- Mouse Deck
  end
  if loc == PRIO_TOFIELD then
    return OPTCheck(c.id)
  end
  if GlobalFusionSummon > 0 then
    if Get_Card_Count_ID(AIDeck(),c.id) == 0 then
	  if FilterPosition(c,POS_FACEUP_ATTACK) then
	    return 9
	  else 
	    return 8
	  end
	else
	  return false
	end
  end
  if loc == PRIO_TOGRAVE then
    return not OPTCheck(c.id)
  end
  if loc == PRIO_DISCARD then
    return not OPTCheck(c.id) or Get_Card_Count_ID(AIDeck(),c.id) < 2
  end
  if loc == PRIO_BANISH then
    return not OPTCheck(c.id)
  end
  return true
end
function WingsCond(loc,c)
  if loc == PRIO_TOHAND then
    return 
	  OPTCheck(c.id) and not HasID(UseLists({AIHand(),AIGrave()}),c.id,true) -- Wings
	  and Get_Card_Count_ID(UseLists({AIHand(),AIST()}),70245411) > 0 -- ToyVendor
	  and (
        CountToyVendorCanUse() > 0
	    or Get_Card_Count_ID(UseLists({AIHand(),AIST()}),24094653) > 0
	  )
  end
  if loc == PRIO_TOFIELD then
    return OPTCheck(c.id)
  end
  if loc == PRIO_TOGRAVE then
    return true
  end
  if loc == PRIO_DISCARD then
    return true
  end
  if loc == PRIO_BANISH then
    return not OPTCheck(c.id)
  end
  return true
end
function PatchworkCond(loc,c)
  if loc == PRIO_TOHAND then
    return OPTCheck(c.id) and not HasID(AIHand(),c.id,true)
  end
  if loc == PRIO_TOFIELD then
    return OPTCheck(c.id)
  end
  if GlobalFusionSummon == 2 then -- FirstMaterial
    return 9
  end
  if loc == PRIO_TOGRAVE then
    return not OPTCheck(c.id)
  end
  if loc == PRIO_DISCARD then
    return true
  end
  if loc == PRIO_BANISH then
    return not OPTCheck(c.id)
  end
  return true
end
-- EdgeImp Cond
function TomahawkCond(loc,c)
  if loc == PRIO_TOHAND then
    return OPTCheck(c.id) and not HasID(AIHand(),c.id,true)
  end
  if loc == PRIO_TOFIELD then
    return OPTCheck(c.id)
  end
  if GlobalFusionSummon == 2 then
    return 8
  end
  if loc == PRIO_TOGRAVE then
    return not OPTCheck(c.id)
  end
  if loc == PRIO_DISCARD then
    return true
  end
  if loc == PRIO_BANISH then
    return not OPTCheck(c.id)
  end
  return true
end
function ChainCond(loc,c)
  if loc == PRIO_TOHAND then
    return OPTCheck(c.id) and not HasID(AIHand(),c.id,true)
  end
  if loc == PRIO_TOFIELD then
    return OPTCheck(c.id)
  end
  if loc == PRIO_TOGRAVE then
    return OPTCheck(c.id)
  end
  if loc == PRIO_DISCARD then
    return OPTCheck(c.id)
  end
  if loc == PRIO_BANISH then
    return not OPTCheck(c.id)
  end
  return true
end
function SabresCond(loc,c)
  if loc == PRIO_TOHAND then
    return 
	  not HasID(AIHand(),c.id,true) -- Sabres
	  and not HasID(UseLists({AIHand(),AIMon()}),79109599,true) -- KoS
	  and CountEgdeImp(UseLists({AIHand(),AIMon()})) == 0 -- EdgeImp
  end
  if loc == PRIO_TOFIELD then
    return OPTCheck(c.id)
  end
  if GlobalFusionSummon == 3 then
    return false
  end
  if loc == PRIO_TOGRAVE then
    return true
  end
  if loc == PRIO_DISCARD then
    return 
	  CountEgdeImp(UseLists({AIHand(),AIMon()})) > 1
	  or (
	    Get_Card_Count_ID(AIGrave(),72413000) > 0 and OPTCheck(72413000)
	  )
  end
  if loc == PRIO_BANISH then
    return not OPTCheck(c.id)
  end
  return true
end
-- Other Cond
function KoSCond(loc,c)
  if loc == PRIO_TOHAND then
    return OPTCheck(c.id) and not HasID(AIHand(),c.id,true)
  end
  if loc == PRIO_TOFIELD then
    return OPTCheck(c.id)
  end
  if GlobalFusionSummon > 0 then
    return 10
  end
  if loc == PRIO_TOGRAVE then
    return not OPTCheck(c.id)
  end
  if loc == PRIO_DISCARD then
    return not OPTCheck(c.id)
  end
  if loc == PRIO_BANISH then
    return not OPTCheck(c.id)
  end
  return true
end
function BulbCond(loc,c)
  if loc == PRIO_TOHAND then
    return OPTCheck(c.id) and not HasID(AIHand(),c.id,true)
  end
  if loc == PRIO_TOFIELD then
    return OPTCheck(c.id)
  end
  if loc == PRIO_TOGRAVE then
    return true
  end
  if loc == PRIO_DISCARD then
    return true
  end
  if loc == PRIO_BANISH then
    return not OPTCheck(c.id)
  end
  return true
end
--FLuffalS Cond
function FFusionCond(loc,c)
  if loc == PRIO_TOHAND then
    return OPTCheck(c.id) and not HasID(AIHand(),c.id,true)
  end
  if loc == PRIO_TOFIELD then
    return OPTCheck(c.id)
  end
  if loc == PRIO_TOGRAVE then
    return not OPTCheck(c.id) or Get_Card_Count_ID(UseLists({AIST(),AIHand()}),c.id) > 1
  end
  if loc == PRIO_DISCARD then
    return not OPTCheck(c.id) or Get_Card_Count_ID(UseLists({AIST(),AIHand()}),c.id) > 0
  end
  if loc == PRIO_BANISH then
    return not OPTCheck(c.id)
  end
  return true
end
function FFactoryCond(loc,c)
  if loc == PRIO_TOHAND then
    return OPTCheck(c.id) and not HasID(AIHand(),c.id,true)
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
    return not OPTCheck(c.id)
  end
  return true
end
function ToyVendorCond(loc,c)
  if loc == PRIO_TOHAND then
    return HasID(AIHand(),c.id,true)
  end
  if loc == PRIO_TOFIELD then
    return OPTCheck(c.id)
  end
  if loc == PRIO_TOGRAVE then
    return not OPTCheck(c.cardid)
  end
  if loc == PRIO_DISCARD then
    return not OPTCheck(c.id)
  end
  if loc == PRIO_BANISH then
    return not OPTCheck(c.id)
  end
  return true
end
-- Spell Cond
function IFusionCond(loc,c)
  if loc == PRIO_TOHAND then
    return OPTCheck(c.id) and not HasID(AIHand(),c.id,true)
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
    return not OPTCheck(c.id)
  end
  return true
end
function PolymCond(loc,c)
  if loc == PRIO_TOHAND then
    return OPTCheck(c.id) and not HasID(AIHand(),c.id,true)
  end
  if loc == PRIO_TOFIELD then
    return OPTCheck(c.id)
  end
  if loc == PRIO_TOGRAVE then
    return not OPTCheck(c.id)
  end
  if loc == PRIO_DISCARD then
    return Get_Card_Count_ID(UseLists({AIST(),AIHand()}),c.id) > 1
  end
  if loc == PRIO_BANISH then
    return not OPTCheck(c.id)
  end
  return true
end
-- Trap Cond
function FReserveCond(loc,c)
  if loc == PRIO_TOHAND then
    return OPTCheck(c.id) and not HasID(AIHand(),c.id,true)
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
    return not OPTCheck(c.id)
  end
  return true
end
-- Frightfur Cond
function FSabreCond(loc,c)
  if loc == PRIO_TOHAND then
    return OPTCheck(c.id) and not HasID(AIHand(),c.id,true)
  end
  if loc == PRIO_TOFIELD then
    return 
	  not HasID(AIMon(),c.id,true)
	  and (
	    Get_Card_Count_ID(AIMon(),85545073) > 0 -- Frightfur Bear
	    or Get_Card_Count_ID(AIMon(),00464362) > 0 -- Frightfur Tiger
	    or Get_Card_Count_ID(AIMon(),57477163) > 0 -- Frightfur Sheep
	  )
	  and (
	    GlobalCheckPolyTarget == 0 -- Check PolyTarget
		or CountFrightfur(AIMon()) > 0 -- Frightfur
	  )
  end
  if loc == PRIO_TOGRAVE then
    return not OPTCheck(c.id)
  end
  if loc == PRIO_DISCARD then
    return not OPTCheck(c.id)
  end
  if loc == PRIO_BANISH then
    return not OPTCheck(c.id)
  end
  return true
end
function FLeoFinish()
  return false
end
function FLeoCond(loc,c)
  if loc == PRIO_TOHAND then
    return OPTCheck(c.id) and not HasID(AIHand(),c.id,true)
  end
  if loc == PRIO_TOFIELD then
    return 
	  OPTCheck(c.id) and FLeoFinish()
	  and (
	    GlobalCheckPolyTarget == 0 -- Check PolyTarget
		or Get_Card_Count_ID(UseLists({AIMon(),AIHand()}),79109599) > 0 -- KoS
	  )
  end
  if loc == PRIO_TOGRAVE then
    return not OPTCheck(c.id)
  end
  if loc == PRIO_DISCARD then
    return not OPTCheck(c.id)
  end
  if loc == PRIO_BANISH then	
    return not OPTCheck(c.id)
  end
  return true
end
function FBearCond(loc,c)
  if loc == PRIO_TOHAND then
    return 
	  OPTCheck(03841833) and not HasID(AIHand(),03841833,true) -- Bear
	  and not HasID(UseLists({AIHand(),AIST()}),70245411,true)
  end
  if loc == PRIO_TOFIELD then
    return 
	  not HasID(AIMon(),c.id,true) -- Allways prio = 1
  end
  if loc == PRIO_TOGRAVE then
    return not OPTCheck(c.id) and not HasID(AIMon(),c.id,true)
  end
  if loc == PRIO_DISCARD then
    return not OPTCheck(c.id)
  end
  if loc == PRIO_BANISH then
    return not OPTCheck(c.id)
  end
  return true
end
function FWolfCond(loc,c)
  if loc == PRIO_TOHAND then
    return OPTCheck(c.id) and not HasID(AIHand(),c.id,true)
  end
  if loc == PRIO_TOFIELD then
    return 
	  not HasID(AIMon(),c.id,true)
	  and (
	    GlobalCheckPolyTarget == 0 -- Check PolyTarget
		or Get_Card_Count_ID(UseLists({AIMon(),AIHand()}),30068120) > 0 -- Sabres
	  )
  end
  if loc == PRIO_TOGRAVE then
    return not OPTCheck(c.id)
  end
  if loc == PRIO_DISCARD then
    return not OPTCheck(c.id)
  end
  if loc == PRIO_BANISH then
    return not OPTCheck(c.id)
  end
  return true
end
function FTigerCond(loc,c)
  if loc == PRIO_TOHAND then
    return not HasID(AIHand(),30068120,true) -- Sabres
  end
  if loc == PRIO_TOFIELD then
    --print("FTigerCond")
    return 
	  not HasID(AIMon(),c.id,true)
	  and #OppField() > 0
	  and (
	    GlobalCheckPolyTarget == 0 -- Check PolyTarget
		or Get_Card_Count_ID(UseLists({AIMon(),AIHand()}),30068120) > 0 -- Sabres
		or Get_Card_Count_ID(UseLists({AIMon(),AIHand()}),79109599) > 0 -- Kos
	  )
  end
  if loc == PRIO_TOGRAVE then
    return not OPTCheck(c.id)
  end
  if loc == PRIO_DISCARD then
    return not OPTCheck(c.id)
  end
  if loc == PRIO_BANISH then
    return not OPTCheck(c.id)
  end
  return true
end
function FSheepCond(loc,c)
  if loc == PRIO_TOHAND then
    return OPTCheck(c.id) and not HasID(AIHand(),c.id,true)
  end
  if loc == PRIO_TOFIELD then
    return 
	  not HasID(AIMon(),c.id,true)
	  and (
	    GlobalCheckPolyTarget == 0 -- Check PolyTarget
		or Get_Card_Count_ID(UseLists({AIMon(),AIHand()}),61173621) > 0 -- Chain
		or Get_Card_Count_ID(UseLists({AIMon(),AIHand()}),79109599) > 0 -- Kos
	  )
  end
  if loc == PRIO_TOGRAVE and not OPTCheck(c.cardid) then -- Instant Fusion
    OPTReset(c.cardid)
    return 99999
  end
  if loc == PRIO_TOGRAVE then
    return not OPTCheck(c.id)
  end
  if loc == PRIO_DISCARD then
    return not OPTCheck(c.id)
  end
  if loc == PRIO_BANISH then
    return not OPTCheck(c.id)
  end
  return true
end

function SVFDCond(loc,c)
  if loc == PRIO_TOFIELD then
    return 
	  not HasID(AIMon(),c.id,true)
	  and (
	    GlobalCheckPolyTarget == 0 -- Check PolyTarget
		or (
		  CardsMatchingFilter(AIMon(),FilterAttribute,ATTRIBUTE_DARK) > 1 -- Dark
		  and CountEgdeImp(AIMon()) > 0
		)
	  )
  end
  return true
end

FluffalPriorityList={
--PRIO_TOHAND = 1
--PRIO_TOFIELD = 3
--PRIO_TOGRAVE = 5
--PRIO_DISCARD = 7
--PRIO_BANISH = 9
 
 [39246582] = {10,1,8,1,4,1,1,1,9,1,DogCond},		-- Fluffal Dog
 [03841833] = {9,1,1,1,1,1,1,1,8,1,BearCond},		-- Fluffal Bear
 [65331686] = {4,1,9,1,1,1,1,1,5,1,OwlCond},		-- Fluffal Owl
 [98280324] = {5,1,1,1,3,1,1,1,6,1,SheepCond},		-- Fluffal Sheep
 [02729285] = {7,1,2,1,1,1,1,1,2,1,CatCond},		-- Fluffal Cat
 [38124994] = {6,1,2,1,1,1,1,1,7,1,RabitCond},		-- Fluffal Rabit
 [06142488] = {1,1,10,1,5,1,4,1,10,1,MouseCond},	-- Fluffal Mouse
 [72413000] = {8,1,1,1,8,1,10,1,1,1,WingsCond},		-- Fluffal Wings
 [00006131] = {1,1,3,1,1,1,1,1,2,1,PatchworkCond},	-- Fluffal Patchwork (BETA)
 [97567736] = {1,1,6,3,8,1,7,1,6,1,TomahawkCond},	-- Edge Imp Tomahawk
 [61173621] = {8,3,5,4,6,1,6,1,4,1,ChainCond},		-- Edge Imp Chain
 [30068120] = {7,2,4,5,7,1,5,1,5,1,SabresCond},		-- Edge Imp Sabres
 [79109599] = {1,1,2,1,1,1,1,1,10,1,KoSCond},		-- King of the Swamp
 [67441435] = {1,1,7,1,9,1,9,1,1,1,BulbCond},		-- Glow-Up Bulb

 [06077601] = {1,1,1,1,1,1,3,1,10,1,FFusionCond},	-- Frightfur Fusion
 [43698897] = {3,1,1,1,1,1,1,1,1,1,FFactoryCond},	-- Frightfur Factory
 [70245411] = {1,1,1,1,2,1,1,1,1,1,ToyVendorCond},	-- Toy Vendor
 [01845204] = {1,1,1,1,3,2,4,2,4,1,IFusionCond},	-- Instant Fusion
 [24094653] = {1,1,1,1,1,1,3,1,3,1,PolymCond},		-- Polymerization
 [43898403] = {1,1,1,1,2,1,2,1,1,1,nil},			-- Twin Twister

 [66127916] = {1,1,1,1,1,1,1,1,1,1,FReserveCond}, 	-- Fusion Reserve
 
 [80889750] = {1,1,6,1,1,1,1,1,4,1,FSabreCond},		-- Frightfur Sabre-Tooth
 [10383554] = {1,1,7,1,2,1,1,1,10,1,FLeoCond},		-- Frightfur Leo
 [85545073] = {5,1,1,1,3,1,1,1,2,1,FBearCond},		-- Frightfur Bear
 [11039171] = {2,1,3,1,2,1,1,1,9,1,FWolfCond},		-- Frightfur Wolf
 [00464362] = {3,1,5,1,5,1,1,1,3,1,FTigerCond},		-- Frightfur Tiger
 [57477163] = {4,1,4,1,4,1,1,1,1,1,FSheepCond},		-- Frightfur Sheep
 [41209827] = {2,1,1,1,1,1,1,1,1,1,SVFDCond}, 			-- Starve Venom Fusion Dragon<
 [33198837] = {1,1,1,1,1,1,1,1,1,1,nil}, 			-- Naturia Beast
 [42110604] = {1,1,1,1,1,1,1,1,1,1,nil}, 			-- Hi-Speedroid Chanbara
 [82633039] = {1,1,1,1,1,1,1,1,1,1,nil}, 			-- Castel
 [83531441] = {1,1,1,1,1,1,1,1,1,1,nil}, 			-- Dante
}