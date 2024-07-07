class_name Monster extends CharacterBody2D

@onready var health_bar = $HealthBar
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var player_indicator = $PlayerIndicator

@export var monster_resource: MonsterResource
var current_health: float
var isEnemy = false

var original_position
signal attack_animation_finished

func _ready():
	health_bar.max_value = monster_resource.health
	current_health = monster_resource.health
	health_bar.value = current_health
	
	animated_sprite_2d.sprite_frames = monster_resource.sprite_frames

func _process(_delta):
	health_bar.value = current_health
	if current_health <= 0:
		if isEnemy:
			var idx = TurnManager.enemyMonsters.find(self)
			TurnManager.enemyMonsters.remove_at(idx)
		else:
			var idx = TurnManager.playerMonsters.find(self)
			TurnManager.playerMonsters.remove_at(idx)
		TurnManager.trigger_reposition()
		queue_free()
		TurnManager.trigger_refresh()

func take_damage(amount: float):
	current_health -= amount
	print(monster_resource.name + " suffered " + str(amount) + " damage")

func animate_attack(target):
	original_position = position
	var tween1 = get_tree().create_tween()
	tween1.tween_property(self, "position", target.position, 0.7).set_trans(Tween.TRANS_CUBIC)
	tween1.play()
	tween1.tween_callback(reset_position)

func reset_position():
	var tween2 = get_tree().create_tween()
	tween2.tween_property(self, "position", original_position, 0.4).set_trans(Tween.TRANS_BACK)
	tween2.play()
	tween2.tween_callback(func(): 
		emit_signal("attack_animation_finished") 
		print("animation finished")
	)
