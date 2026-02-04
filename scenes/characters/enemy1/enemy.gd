extends EnemyBase
class_name Enemy

var atack_direction: Vector2 = Vector2.ZERO
var last_atack_direction: Vector2 = Vector2.ZERO

func instansiate_inner():
	facing_right = false
	speed = GameVariables.enemy_speed
	max_health = GameVariables.enemy_max_health
	current_health = GameVariables.enemy_max_health
	kill_score = GameVariables.enemy_kill_score
	
	velosity_overrides_available = true
	damage = GameVariables.enemy_damage
	
func override_velocity(current_velocity):
	set_collision_mask_value(1, false)
	if(atack_direction == Vector2.ZERO):
		var new_dir = global_position.direction_to(Game.player.global_position)
		
		if new_dir == Vector2.ZERO:
			new_dir = last_atack_direction
		else:
			last_atack_direction = new_dir
			
		atack_direction = new_dir
	current_velocity = atack_direction * GameVariables.enemy_attack_speed
	get_tree().create_timer(GameVariables.enemy_attack_time).timeout.connect(reset_leap)
	
	return current_velocity
		
func reset_leap():
	atack_direction = Vector2.ZERO
	set_collision_mask_value(1, true)
	stop_moving = true
	get_tree().create_timer(GameVariables.enemy_atack_cooldown).timeout.connect(set_cooldown)
	
func set_cooldown():
	stop_moving = false
