extends Control

@onready var v_box_container = $Panel/ScrollContainer/HBoxContainer/VBoxContainer
@onready var v_box_container_2 = $Panel/ScrollContainer/HBoxContainer/VBoxContainer2
@onready var v_box_container_3 = $Panel/ScrollContainer/HBoxContainer/VBoxContainer3
@onready var v_box_container_4 = $Panel/ScrollContainer/HBoxContainer/VBoxContainer4
const MONSTER_CARD = preload("res://Scenes/Objects/MonsterCard.tscn")

var cards = []

func _ready():
	var i = 0
	var colums = [v_box_container, v_box_container_2, v_box_container_3, v_box_container_4]
	GameManager.active_squad.clear()
	for e in GameManager.player_monster_collection:
		if i == 4:
			i = 0
		
		var instance = MONSTER_CARD.instantiate()
		instance.monster_resource = e
		colums[i].add_child(instance)
		instance.update_card()
		cards.append(instance)
		i += 1

func _on_exit_button_pressed():
	if GameManager.active_squad.size() == 0:
		print("Select at least 1 monster")
		return
	get_tree().change_scene_to_file("res://Scenes/Game/battle.tscn")

func _on_info_button_pressed():
	for e in cards:
		e.enable_info_panel()

func _on_shop_button_pressed():
		get_tree().change_scene_to_file("res://Scenes/Game/shop.tscn")
