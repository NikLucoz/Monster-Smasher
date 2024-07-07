extends Control

const EARTH = preload("res://Assets/Icons/earth.svg")
const FIRE = preload("res://Assets/Icons/fire.svg")
const GRASS = preload("res://Assets/Icons/Grass.svg")
const WATER = preload("res://Assets/Icons/water.svg")
@onready var panel = $Panel/Panel
@onready var panel_2 = $Panel/Panel2
@onready var panel_3 = $Panel/Panel3

@onready var coin_value = $Panel/CoinPanel/CoinValue
@onready var monster_sprite_1 = $Panel/Panel/MonsterSprite1
@onready var monster_sprite_2 = $Panel/Panel2/MonsterSprite2
@onready var monster_sprite_3 = $Panel/Panel3/MonsterSprite3
@onready var refresh_coin_value = $Panel/RefreshButton/Button/CoinValue2

#FIRST MONSTER CARD
@onready var monster_info_1 = $Panel/Panel/MonsterInfo1
@onready var card1_name_label = $Panel/Panel/MonsterInfo1/NameLabel
@onready var card1_monster_type_icon = $Panel/Panel/MonsterInfo1/MonsterTypeIcon
@onready var card1_health_label = $Panel/Panel/MonsterInfo1/HealthLabel
@onready var card1_damage_label = $Panel/Panel/MonsterInfo1/DamageLabel
@onready var card1_monster_preferred_type_icon = $Panel/Panel/MonsterInfo1/MonsterPreferredTypeIcon
@onready var card1_cost_label = $Panel/Panel/Control/CostLabel
@onready var fire_modifier = $Panel/Panel/MonsterInfo1/FireModifier
@onready var grass_modifier = $Panel/Panel/MonsterInfo1/GrassModifier
@onready var water_modifier = $Panel/Panel/MonsterInfo1/WaterModifier
@onready var earth_modifier = $Panel/Panel/MonsterInfo1/EarthModifier

#SECOND MONSTER CARD
@onready var monster_info_2 = $Panel/Panel2/MonsterInfo2
@onready var card2_name_label = $Panel/Panel2/MonsterInfo2/NameLabel
@onready var card2_monster_type_icon = $Panel/Panel2/MonsterInfo2/MonsterTypeIcon
@onready var card2_health_label = $Panel/Panel2/MonsterInfo2/HealthLabel
@onready var card2_damage_label = $Panel/Panel2/MonsterInfo2/DamageLabel
@onready var card2_monster_preferred_type_icon = $Panel/Panel2/MonsterInfo2/MonsterPreferredTypeIcon
@onready var card2_cost_label = $Panel/Panel2/Control/CostLabel
@onready var fire_modifier2 = $Panel/Panel2/MonsterInfo2/FireModifier
@onready var grass_modifier2 = $Panel/Panel2/MonsterInfo2/GrassModifier
@onready var water_modifier2 = $Panel/Panel2/MonsterInfo2/WaterModifier
@onready var earth_modifier2 = $Panel/Panel2/MonsterInfo2/EarthModifier

#THIRD MONSTER CARD
@onready var monster_info_3 = $Panel/Panel3/MonsterInfo3
@onready var card3_name_label = $Panel/Panel3/MonsterInfo3/NameLabel
@onready var card3_monster_type_icon = $Panel/Panel3/MonsterInfo3/MonsterTypeIcon
@onready var card3_health_label = $Panel/Panel3/MonsterInfo3/HealthLabel
@onready var card3_damage_label = $Panel/Panel3/MonsterInfo3/DamageLabel
@onready var card3_monster_preferred_type_icon = $Panel/Panel3/MonsterInfo3/MonsterPreferredTypeIcon
@onready var card3_cost_label = $Panel/Panel3/Control/CostLabel
@onready var fire_modifier3 = $Panel/Panel3/MonsterInfo3/FireModifier
@onready var grass_modifier3 = $Panel/Panel3/MonsterInfo3/GrassModifier
@onready var water_modifier3 = $Panel/Panel3/MonsterInfo3/WaterModifier
@onready var earth_modifier3 = $Panel/Panel3/MonsterInfo3/EarthModifier

var shop_monsters: Array[MonsterResource]
var info_visible: bool = false

func _ready():
	shop_monsters = GameManager.get_shop_monsters()
	monster_info_1.set_visible(false)
	monster_info_2.set_visible(false)
	monster_info_3.set_visible(false)
	update_shop_ui()

func _on_refresh_shop_button_pressed():
	if GameManager.coins - GameManager.shop_refresh_cost >= 0:
		shop_monsters.clear()
		var new_shop_monsters = GameManager.get_shop_monsters()
		shop_monsters = new_shop_monsters.filter(func(e): 
			if shop_monsters.has(e):
				return null
			return e
		)
		
		if shop_monsters == []:
			return
			#Messaggio mostri finiti
			
		GameManager.coins -= GameManager.shop_refresh_cost
		GameManager.shop_refresh_cost *= 2
		if GameManager.shop_refresh_cost * 2 > GameManager.max_shop_refresh_cost:
			GameManager.shop_refresh_cost = GameManager.max_shop_refresh_cost
		update_shop_ui()
	
func update_shop_ui():
	coin_value.text = str(GameManager.coins)
	refresh_coin_value.text = str(GameManager.shop_refresh_cost)
	
	if shop_monsters.size() == 0:
		monster_info_1.set_visible(false)
		monster_info_2.set_visible(false)
		monster_info_3.set_visible(false)
		panel.set_visible(false)
		panel_2.set_visible(false)
		panel_3.set_visible(false)
		return
	
	if (shop_monsters[0] != null):
		monster_sprite_1.texture = shop_monsters[0].sprite_frames.get_frame_texture("Idle", 0)
		card1_name_label.text = shop_monsters[0].name
		card1_damage_label.text = str(shop_monsters[0].damage)
		card1_health_label.text = str(shop_monsters[0].health)
		card1_cost_label.text = str(shop_monsters[0].cost)
		fire_modifier.text = "x" + str(shop_monsters[0].fire_damage_modifier)
		water_modifier.text = "x" + str(shop_monsters[0].water_damage_modifier)
		earth_modifier.text = "x" + str(shop_monsters[0].earth_damage_modifier)
		grass_modifier.text = "x" + str(shop_monsters[0].grass_damage_modifier)	
		monster_info_1.set_visible(info_visible)
	else:
		panel.set_visible(false)

	if (shop_monsters.size() > 1 && shop_monsters[1] != null):
		monster_sprite_2.texture = shop_monsters[1].sprite_frames.get_frame_texture("Idle", 0)
		card2_name_label.text = shop_monsters[1].name
		card2_damage_label.text = str(shop_monsters[1].damage)
		card2_health_label.text = str(shop_monsters[1].health)
		card2_cost_label.text = str(shop_monsters[1].cost)
		fire_modifier2.text = "x" + str(shop_monsters[1].fire_damage_modifier)
		water_modifier2.text = "x" + str(shop_monsters[1].water_damage_modifier)
		earth_modifier2.text = "x" + str(shop_monsters[1].earth_damage_modifier)
		grass_modifier2.text = "x" + str(shop_monsters[1].grass_damage_modifier)
		monster_info_2.set_visible(info_visible)
	else:
		panel_2.set_visible(false)
	
	if (shop_monsters.size() > 2 && shop_monsters[2] != null):
		monster_sprite_3.texture = shop_monsters[2].sprite_frames.get_frame_texture("Idle", 0)
		card3_name_label.text = shop_monsters[2].name
		card3_damage_label.text = str(shop_monsters[2].damage)
		card3_health_label.text = str(shop_monsters[2].health)
		card3_cost_label.text = str(shop_monsters[2].cost)
		fire_modifier3.text = "x" + str(shop_monsters[2].fire_damage_modifier)
		water_modifier3.text = "x" + str(shop_monsters[2].water_damage_modifier)
		earth_modifier3.text = "x" + str(shop_monsters[2].earth_damage_modifier)
		grass_modifier3.text = "x" + str(shop_monsters[2].grass_damage_modifier)
		monster_info_3.set_visible(info_visible)
	else:
		panel_3.set_visible(false)
	
	var a = [card1_monster_type_icon, card2_monster_type_icon, card3_monster_type_icon]
	var b = [card1_monster_preferred_type_icon, card2_monster_preferred_type_icon, card3_monster_preferred_type_icon]
	for i in range(shop_monsters.size()):
		if shop_monsters[i] != null:
			match shop_monsters[i].type:
				"GRASS":
					a[i].texture = GRASS
				"FIRE":
					a[i].texture = FIRE
				"WATER":
					a[i].texture = WATER
				"EARTH":
					a[i].texture = EARTH
			match shop_monsters[i].preferred_enemy:
				"GRASS":
					b[i].texture = GRASS
				"FIRE":
					b[i].texture = FIRE
				"WATER":
					b[i].texture = WATER
				"EARTH":
					b[i].texture = EARTH

func buy_monster(id):
	if GameManager.coins - shop_monsters[id].cost >= 0:
		GameManager.player_monster_collection.append(shop_monsters[id])
		GameManager.coins -= shop_monsters[id].cost
		var new_monster = GameManager.get_shop_monsters_with_filter(shop_monsters)
		
		if new_monster == null:
			var a = [panel, panel_2, panel_3]
			a[id].set_visible(false)
			return
		shop_monsters[id] = new_monster
		update_shop_ui()

func _on_exit_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Game/squad_menu.tscn")

func _on_info_button_pressed():
	info_visible = !info_visible
	update_shop_ui()

func _on_buy_button1_pressed():
	buy_monster(0)

func _on_buy_button2_pressed():
	buy_monster(1)

func _on_buy_button3_pressed():
	buy_monster(2)
