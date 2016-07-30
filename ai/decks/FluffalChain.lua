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
function ChainFTiger(c)
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
  
  if HasIDNotNegated(cards,61173621,ChainChain) then -- Chain
    return 1,CurrentIndex
  end
  
  if HasIDNotNegated(cards,00464362,ChainFTiger) then -- Frightfur Tiger
    return 1,CurrentIndex
  end
  
  if HasIDNotNegated(cards,66127916,ChainFReserve) then -- FusionReserve
    return 1,CurrentIndex
  end
  
  return nil
end
