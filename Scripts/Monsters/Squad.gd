class_name Squad extends Node

@onready var BattleManager = $".."
@export var monsterResources: Array[MonsterResource]
@export var spawnPoints: Array[Node2D]
@export var isEnemySquad: bool = false

var active_monster: int # idx of current attacking monster

const MONSTER = preload("res://Scenes/Objects/monster.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	if !isEnemySquad:
		monsterResources = GameManager.active_squad
	else:
		monsterResources = GameManager.generate_random_squad()
		
	for idx in range(monsterResources.size()):
		var mr = monsterResources[idx]
		var instance = MONSTER.instantiate()
		instance.monster_resource = mr
		instance.transform = spawnPoints[idx].transform
		add_child(instance)
		
		if isEnemySquad:
			instance.get_child(0).flip_h = true
			TurnManager.add_enemy_monster(instance)
			instance.isEnemy = true
		else:
			TurnManager.add_player_monster(instance)

func attack(idx):
	var actor: Monster
	var target: Monster
	
	if isEnemySquad:
		actor = TurnManager.enemyMonsters[active_monster]
		for monster in TurnManager.playerMonsters:
			if monster.monster_resource.type == actor.monster_resource.preferred_enemy:
				target = monster
		if target == null:
			target = TurnManager.playerMonsters.pick_random()
	else:
		actor = TurnManager.playerMonsters[active_monster]
		target = TurnManager.enemyMonsters[idx]
	
	if !actor.is_connected("attack_animation_finished", pass_turn):
		actor.connect("attack_animation_finished", pass_turn)

	var damage_mod = actor.monster_resource.get_damage_modifier(target.monster_resource.type)
	var damage = actor.monster_resource.damage * damage_mod
	actor.animate_attack(target)
	target.take_damage(damage)

func pass_turn():
	active_monster += 1
	BattleManager.is_attacking = false
	if isEnemySquad:
		if active_monster > TurnManager.enemyMonsters.size() - 1: 
			active_monster = 0
			print("Enemy Turn Ended \n")
			TurnManager.turn = TurnManager.ALLY_TURN
			return

		TurnManager.turn = TurnManager.ENEMY_TURN
	else:
		# if there no more monster to attack give enemy the turn
		if active_monster > TurnManager.playerMonsters.size() - 1: 
			active_monster = 0
			print("Ally Turn Ended \n")
			TurnManager.turn = TurnManager.ENEMY_TURN
			return
		BattleManager.player_ui_refresh()
		TurnManager.turn = TurnManager.ALLY_TURN

func skip_turn():
	active_monster += 1
	if active_monster > TurnManager.playerMonsters.size() - 1: 
		active_monster = 0
		print("Ally Turn Ended \n")
		TurnManager.turn = TurnManager.ENEMY_TURN
		return
	BattleManager.player_ui_refresh()
	BattleManager.is_attacking = false
	TurnManager.turn = TurnManager.ALLY_TURN
