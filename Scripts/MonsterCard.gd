extends Control
@onready var monster_info = $Panel/MonsterInfo
@onready var monster_sprite = $Panel/MonsterSprite
@onready var name_label = $Panel/MonsterInfo/NameLabel
@onready var monster_type_icon = $Panel/MonsterInfo/MonsterTypeIcon
@onready var health_label = $Panel/MonsterInfo/HealthLabel
@onready var damage_label = $Panel/MonsterInfo/DamageLabel
@onready var monster_preferred_type_icon = $Panel/MonsterInfo/MonsterPreferredTypeIcon
@onready var fire_modifier = $Panel/MonsterInfo/FireModifier
@onready var grass_modifier = $Panel/MonsterInfo/GrassModifier
@onready var water_modifier = $Panel/MonsterInfo/WaterModifier
@onready var earth_modifier = $Panel/MonsterInfo/EarthModifier
@onready var panel = $Panel


const EARTH = preload("res://Assets/Icons/earth.svg")
const FIRE = preload("res://Assets/Icons/fire.svg")
const GRASS = preload("res://Assets/Icons/Grass.svg")
const WATER = preload("res://Assets/Icons/water.svg")

var info_visible = false
var monster_resource: MonsterResource
var selected: bool
signal monster_selected

func update_card():
	monster_sprite.texture = monster_resource.sprite_frames.get_frame_texture("Idle", 0)
	name_label.text = monster_resource.name
	health_label.text = str(monster_resource.health)
	damage_label.text = str(monster_resource.damage)
	
	match monster_resource.type:
		"GRASS":
			monster_type_icon.texture = GRASS
		"FIRE":
			monster_type_icon.texture = FIRE
		"WATER":
			monster_type_icon.texture = WATER
		"EARTH":
			monster_type_icon.texture = EARTH
		
	match monster_resource.preferred_enemy:
		"GRASS":
			monster_preferred_type_icon.texture = GRASS
		"FIRE":
			monster_preferred_type_icon.texture = FIRE
		"WATER":
			monster_preferred_type_icon.texture = WATER
		"EARTH":
			monster_preferred_type_icon.texture = EARTH

	fire_modifier.text = "x" + str(monster_resource.fire_damage_modifier)
	water_modifier.text = "x" + str(monster_resource.water_damage_modifier)
	earth_modifier.text = "x" + str(monster_resource.earth_damage_modifier)
	grass_modifier.text = "x" + str(monster_resource.grass_damage_modifier)

# Called when the node enters the scene tree for the first time.
func enable_info_panel():
	info_visible = !info_visible
	monster_info.set_visible(info_visible)

func _on_select_button_pressed():
	selected = !selected
	
	# add to playersquad
	if selected:
		print("trying to select")
		
		if GameManager.active_squad.size() == 3:
			print("not selected, active squad max number reached")
			selected = false
			return
		
		GameManager.active_squad.append(monster_resource)
		update_ui()
		print("selected")
	else:
		print("de-selected")
		
		var idx = GameManager.active_squad.find(monster_resource)
		if idx != -1:
			GameManager.active_squad.remove_at(idx)
		update_ui()

func update_ui():
	var new_stylebox_normal: StyleBoxFlat = panel.get_theme_stylebox('panel')
	if selected:
		new_stylebox_normal.border_color = "#2d9f37"
		panel.add_theme_stylebox_override("panel", new_stylebox_normal)
	else:
		new_stylebox_normal.border_color = "#cccccc"
		panel.add_theme_stylebox_override("panel", new_stylebox_normal)
