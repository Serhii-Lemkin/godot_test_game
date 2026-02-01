extends CharacterBody2D
class_name PlainBullet

var direction: float = 0
var speed: float = 500.0
var damage: float = 1
var start_position: Vector2
var start_rotation: float = 0
	
func _ready() -> void:
	global_position = start_position
	global_rotation = start_rotation
	add_to_group("bullet")
	await get_tree().create_timer(15).timeout

func _process(delta: float) -> void:
	velocity = Vector2(speed, 0).rotated(direction)
	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") or body.is_in_group("bullet"):
		return
		
	if body is EnemyBase:
		var rnd = randf()
		var is_crit = rnd < GameVariables.player_crit_chance
		var calculated_damage = 0.0
		if is_crit:
			calculated_damage = damage * GameVariables.player_crit_multiplier
		else:
			calculated_damage = damage
			
		body.take_damage(calculated_damage)
		self.queue_free()
	else: self.queue_free()
