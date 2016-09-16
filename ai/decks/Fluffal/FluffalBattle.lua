FluffalAtt={
39246582, -- Fluffal Dog
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
83531441, -- Dante
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
      result=POS_FACEUP_DEFENSE
    end
  end
  if id == 57477163 and GlobalIFusion > 0 then -- FSheep by IFUsion
    result = POS_FACEUP_DEFENCE
  end
  if id == 57477163 then -- FSheep
      local frightfurAtk = 2000 + FrightfurBoost(id)
      if CanAttackAttackMin(OppMon(),false,(frightfurAtk + 1),nil,nil) > 0
	  and CanAttackAttackMax(OppMon(),false,frightfurAtk,nil,nil) == 0
	  then
        result = POS_FACEUP_DEFENCE
	  else
	    result = POS_FACEUP_ATTACK
      end
	  --print("FSheep - Atk: "..frightfurAtk)
  end
  if id == 80889750 then -- FSabreTooth
      local frightfurAtk = 2400 + FrightfurBoost(id)
      if CanAttackAttackMin(OppMon(),false,(frightfurAtk + 1),nil,nil) > 0
	  and CanAttackAttackMax(OppMon(),false,frightfurAtk,nil,nil) == 0
	  then
        result = POS_FACEUP_DEFENCE
	  else
	    result = POS_FACEUP_ATTACK
      end
	  --print("FSabreTooth - Atk: "..frightfurAtk)
  end
  if Duel.GetTurnCount() == 1
  and (
    id == 61173621 -- Chain
	or id == 30068120 -- Sabres
	or id == 83531441 -- Dante
  )
  then
    result = POS_FACEUP_DEFENSE
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
  and (
    CanWinBattle(cards[CurrentIndex],targets,true,false)
	or #targets == 0
  )
  then
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

function FrightfurBoost(frightfurId)
  local boost = 0
  local countFrighfurs = CountFrightfur(AIMon()) + 1 -- Own

  if frightfurId == 80889750 -- FSabreTooth
  then
    if CountFrightfur(AIGrave()) > 0 then
      countFrighfurs = countFrighfurs + 1
	  if not HasID(AIMon(),00464362,true) -- FTiger Field
	  and HasID(AIGrave(),00464362,true) -- FTiger Grave
	  then
	    boost = boost + (countFrighfurs * 300)
	  end
	end
	boost = boost + 400
  end
  if frightfurId == 00464362 -- Tiger
  then
    boost = boost + (countFrighfurs * 300)
  end
  if frightfurId == 57477163 -- FSheep
  then
    boost = boost + 800
  end

  if HasIDNotNegated(AIMon(),80889750,true) -- FSabreTooth
  then
    boost = boost + 400
  end
  if HasIDNotNegated(AIMon(),00464362,true) -- FTiger
  then
    boost = boost + (countFrighfurs * 300)
  end

  return boost
end

function CanAttackAttackMin(cards,direct,attack,filter,opt)
  local result = 0
  for i=1, #cards do
    if CanAttack(cards[i],direct,filter,opt)
	and FilterAttackMin(cards[i],attack)
	then
	  result = result + 1
	end
  end
  return result
end
function CanAttackAttackMax(cards,direct,attack,filter,opt)
  local result = 0
  for i=1, #cards do
    if CanAttack(cards[i],direct,filter,opt)
	and FilterAttackMax(cards[i],attack)
	then
	  result = result + 1
	end
  end
  return result
end