extends Node

var coins: float = 200
@export var all_monsters: Array[MonsterResource]
@export var player_monster_collection: Array[MonsterResource]
@export var active_squad: Array[MonsterResource]
@export var shop_refresh_cost = 30
@export var max_shop_refresh_cost = 600
@export var music_on = true
var player_won = false

func _init():
	if player_monster_collection.is_empty():
		var intial_monster = preload("res://Creatures/Jared/Jared.tres")
		player_monster_collection.append(intial_monster)

func _ready():
	var music: AudioStreamPlayer2D = MusicLoop.get_child(0, false)
	music.autoplay = music_on
	music.playing = music_on

func generate_random_squad() -> Array[MonsterResource]:
	var squad: Array[MonsterResource] = []
	for i in range(active_squad.size()):
		squad.append(all_monsters.pick_random())
	return squad

func get_shop_monsters() -> Array[MonsterResource]:
	var shop:Array[MonsterResource] = []
	var array:Array[MonsterResource] = all_monsters.filter(func(element): 
		if !player_monster_collection.has(element):
			return element
	)
	
	if array == []:
		return []

	
	for i in range(0, 3):
		if array.size() != 0:
			var m = array.pick_random()
			array.erase(m)
			shop.append(m)
		else:
			shop.append(null)

	return shop

func get_shop_monsters_with_filter(shop_monster: Array[MonsterResource]) -> MonsterResource:
	var array = all_monsters.filter(func(element): 
		if !shop_monster.has(element) && !player_monster_collection.has(element):
			return element
	)
	if array.is_empty():
		return null
	
	return array.pick_random()

func get_shop_monster():
	var m = get_shop_monsters()
	if m != []:
		return m[0]
	else:
		return null

