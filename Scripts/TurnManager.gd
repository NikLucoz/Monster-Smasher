extends Node

enum {ALLY_TURN, ENEMY_TURN, END_TURN}

var turn : int:
	get: return turn
	set(value):
		turn = value
		match turn:
			ALLY_TURN: emit_signal("ally_turn_started")
			ENEMY_TURN: emit_signal("enemy_turn_started")
			END_TURN: emit_signal("end_turn_started")

signal ally_turn_started()
signal enemy_turn_started()
signal end_turn_started()
signal refresh_triggered()
signal reposition_monsters()

var playerMonsters: Array[Monster]
var enemyMonsters: Array[Monster]

func trigger_refresh():
	emit_signal("refresh_triggered")

func trigger_reposition():
	emit_signal("reposition_monsters")

func add_enemy_monster(m: Monster):
	enemyMonsters.append(m)

func add_player_monster(m: Monster):
	playerMonsters.append(m)
