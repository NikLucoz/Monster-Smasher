extends Node

@onready var title = $Title
@onready var money_label = $MoneyLabel
@onready var texture_rect = $TextureRect

func _ready():
	TurnManager.playerMonsters.clear()
	TurnManager.enemyMonsters.clear()
	GameManager.active_squad.clear()
	
	if GameManager.player_won:
		title.text = "You Win!"
		var coins = randi_range(30, 100)
		GameManager.coins += coins
		money_label.text = "+" + str(coins) + " added"
	else:
		title.text = "You Lose!"
		texture_rect.set_visible(false)
		money_label.set_visible(false)

func _on_skip_turn_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Game/squad_menu.tscn")
