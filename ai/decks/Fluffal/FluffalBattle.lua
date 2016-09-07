FluffalAtt={
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
--65331686, -- Fluffal Owl
98280324, -- Fluffal Sheep
02729285, -- Fluffal Cat
38124994, -- Fluffal Rabit
06142488, -- Fluffal Mouse
72413000, -- Fluffal Wings
00006131, -- Fluffal Patchwork (BETA)

--61173621, -- Edge Imp Chain
--30068120, -- Edge Imp Sabres
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
      result=POS_FACEUP_DEFENSE
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
  if NotNegated(attacker) then
    -- Frightfur Sheep
    if id == 57477163 and CanWinBattle(attacker,cards,true,false) then
      return FrightfurSheepAttackTarget(cards,attacker,false)
    end
  end
 return nil
end

function FrightfurSheepAttackTarget(cards,source,ignorebonus,filter,opt)
  local atk = source.attack
  if ignorebonus and source.bonus and source.bonus > 0 then
    atk = math.max(0,atk - source.bonus)
  end
  local result = nil
  for i=1,#cards do
    local c = cards[i]
    c.index = i
    if FilterPosition(c,POS_FACEUP_ATTACK) then
      if c.attack<atk or CrashCheck(source) and c.attack==atk then 
        c.prio = c.attack
      else
        c.prio = c.attack * -1
      end
    end
    if FilterPosition(c,POS_DEFENSE) then
	  if c.defense < atk then 
        c.prio = c.defense
	  else
	    c.prio = c.defense * -1
	  end
    end
    if filter and (opt and not filter(c,opt) or opt==nil and  not filter(c)) 
    then
      c.prio = (c.prio or 0)-99999
    end
    if c.prio and c.prio>0 and not BattleTargetCheck(c,source) then
      c.prio = -4
    end
    if not AttackBlacklistCheck(c,source) then
      c.prio = (c.prio or 0)-99999
    end
    if CanFinishGame(source,c) then
      c.prio=99999
    end
    if c.prio and c.prio>0 and FilterPublic(c) then
      if FilterType(c,TYPE_SYNCHRO+TYPE_RITUAL+TYPE_XYZ+TYPE_FUSION) then
        c.prio = c.prio + 1
      end
      if FilterType(c,TYPE_EFFECT) then
        c.prio = c.prio + 1
      end
      if c.level>4 then
        c.prio = c.prio + 1
      end
    end
    if CurrentOwner(c)==1 then
      c.prio = -1*c.prio
    end
  end
  table.sort(cards,function(a,b) return a.prio > b.prio end)
  result={cards[1].index}
  return result
end


function FluffalAttackBoost(cards)  
  for i=1,#cards do
    local c=cards[i]
    if c.id == 42110604 then -- Chanbara
      c.attack = c.attack + 200
    end
	if c.id == 57477163 then -- Frightfur Sheep
	  local FSheepOwnBoost = c.attack - c.base_attack
	  FSheepOwnBoost = FSheepOwnBoost - (Get_Card_Count_ID(AIDeck(),80889750) * 400) -- Sabre-Tooth
	  if HasID(AIMon(),00464362,true) then -- Frightfur Tiger
	    FSheepOwnBoost = FSheepOwnBoost - (CountFrightfur(AIMon()) * 300)
	  end
	  --print("FSheepOwnBoost: "..FSheepOwnBoost)
	  if 
	  FSheepOwnBoost < 800
	  and OPTCheck(c.cardid)
	  then
	    c.attack = c.attack + 800
	  end
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
  local FrightfurSheep = {}
  
  for i=1,#targets do
    if targets[i]:is_affected_by(EFFECT_CANNOT_BE_BATTLE_TARGET)==0 then
      attackable[#attackable+1]=targets[i]
    end
    if targets[i]:is_affected_by(EFFECT_MUST_BE_ATTACKED)>0 then
      mustattack[#mustattack+1]=targets[i]
    end
  end
  
  if #mustattack>0 then
    targets = mustattack
  else
    targets = attackable
  end
  ApplyATKBoosts(targets)
  
  if HasIDNotNegated(cards,57477163) -- Frightfur Sheep
  and CanWinBattle(cards[CurrentIndex],targets,true,false) then 
    print("FSheep - Attack")
    return Attack(IndexByID(cards,57477163))
  end
  if HasIDNotNegated(cards,10383554) -- Frightfur Leo
  and CanWinBattle(cards[CurrentIndex],targets,true,false) then 
    return Attack(IndexByID(cards,10383554))
  end
  --if HasIDNotNegated(cards,80889750) -- Frightfur Sabre-Tooth
  --and CanWinBattle(cards[CurrentIndex],targets,true,false) then 
    --return Attack(IndexByID(cards,80889750))
  --end
  
 return nil
end