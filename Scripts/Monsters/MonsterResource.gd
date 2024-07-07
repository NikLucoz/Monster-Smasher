class_name MonsterResource extends Resource

@export var name = "Jared"
@export var sprite_frames: SpriteFrames
@export var health = 20
@export var damage = 10
@export var cost = 100
@export_enum("FIRE", "WATER", "EARTH", "GRASS") var type = "GRASS"
@export_enum("FIRE", "WATER", "EARTH", "GRASS") var preferred_enemy = "WATER"

#@export var fire_resistance_modifier = 0.23
#@export var water_resistance_modifier = 0.23
#@export var earth_resistance_modifier = 0.23
#@export var grass_resistance_modifier = 0.23

@export var fire_damage_modifier = 0.23
@export var water_damage_modifier = 0.23
@export var earth_damage_modifier = 0.23
@export var grass_damage_modifier = 0.23

func get_damage_modifier(enemy_type):
	match enemy_type:
		"FIRE":
			return fire_damage_modifier
		"WATER":
			return water_damage_modifier
		"EARTH":
			return earth_damage_modifier
		"GRASS":
			return grass_damage_modifier
