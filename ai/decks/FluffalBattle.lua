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
  if id == 57477163 and GlobalIFusion == 1 then -- FSheep by IFUsion
    return POS_FACEUP_DEFENCE
  end
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

function FluffalAttackBoost(cards)
  for i=1,#cards do
    local c=cards[i]
    if c.id == 57477163 and OPTCheck(57477163) then -- Bad Implement
      c.attack = c.attack + 800
    end
  end
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