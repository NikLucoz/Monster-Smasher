extends Node
@onready var end_turn_button = $Control/Panel
@onready var attack_monster_button = $Control/AttackMonsterButton
@onready var attack_monster_button_2 = $Control/AttackMonsterButton2
@onready var attack_monster_button_3 = $Control/AttackMonsterButton3

@onready var info_panels = $PlayerSquad/Control

@onready var player_squad = $PlayerSquad
@onready var enemy_squad = $EnemySquad
@onready var auto_scroller = $AutoScroller

var battle_finished = false
var is_attacking = false
var info_pressed = false

func _ready():
	auto_scroller.set_visible(true)
	TurnManager.connect("ally_turn_started", _on_ally_turn_started)
	TurnManager.connect("enemy_turn_started", _on_enemy_turn_started)
	TurnManager.connect("end_turn_started", _on_end_turn_started)
	TurnManager.connect("refresh_triggered", player_ui_refresh)
	TurnManager.connect("reposition_monsters", _on_reposition_monsters)
	TurnManager.turn = TurnManager.ALLY_TURN

func _on_ally_turn_started():
	if !check_winning():
		print("Ally Turn Started")
		player_ui_refresh()
	else:
		TurnManager.turn = TurnManager.END_TURN

func _on_enemy_turn_started():
	if !check_winning():
		print("Enemy Turn Started")
		hide_player_ui()
		enemy_squad.attack(-1)
	else:
		TurnManager.turn = TurnManager.END_TURN

func _on_end_turn_started():
	print("Battle Ended")
	
	if TurnManager.playerMonsters.size():
		GameManager.player_won = true
	else:
		GameManager.player_won = false
		
	get_tree().change_scene_to_file("res://Scenes/Game/battle_finished.tscn")
	hide_player_ui()

func check_winning():
	if (TurnManager.playerMonsters.size() == 0 || TurnManager.enemyMonsters.size() == 0) && !is_attacking:
		return true
	return false

func player_ui_refresh():
	hide_player_ui()
	show_player_ui()

func show_player_ui():
	hide_player_ui()
	var attack_buttons: Array[Button] = [attack_monster_button, attack_monster_button_2, attack_monster_button_3]
	for i in range(TurnManager.enemyMonsters.size()):
		attack_buttons[i].set_visible(true)
	
	if !TurnManager.playerMonsters.is_empty():
		TurnManager.playerMonsters[player_squad.active_monster].player_indicator.set_visible(true)
	
	end_turn_button.set_visible(true)

func hide_player_ui():
	end_turn_button.set_visible(false)
	attack_monster_button.set_visible(false)
	attack_monster_button_2.set_visible(false)
	attack_monster_button_3.set_visible(false)
	
	for e in TurnManager.playerMonsters:
		e.player_indicator.set_visible(false)

func _on_reposition_monsters():
	
	for i in range(TurnManager.playerMonsters.size()):
		TurnManager.playerMonsters[i].position = player_squad.spawnPoints[i].position
		
	for i in range(TurnManager.enemyMonsters.size()):
		TurnManager.enemyMonsters[i].position = enemy_squad.spawnPoints[i].position

func _on_attack_monster_button_pressed():
	if !is_attacking:
		player_squad.attack(0)
		is_attacking = true

func _on_attack_monster_button_2_pressed():
	if !is_attacking:
		player_squad.attack(1)
		is_attacking = true

func _on_attack_monster_button_3_pressed():
	if !is_attacking:
		player_squad.attack(2)
		is_attacking = true

func _on_skip_turn_button_pressed():
	player_squad.skip_turn()

func _on_info_button_pressed():
	info_pressed = !info_pressed
	info_panels.set_visible(info_pressed)
