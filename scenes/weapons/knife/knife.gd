extends WeaponBase

var swing_limit_reached = false
@onready var knife: Node2D = $"."

func _ready() -> void:
	area.connect("body_entered", Callable(self, "_on_area_body_entered"))
	damage = GameVariables.knife_dmg
	offset_distance = GameVariables.knife_offset_distance
	angle_correction = GameVariables.knife_angle_correction
	animation_speed = GameVariables.knife_animation_speed
	rotation_speed = GameVariables.knife_rotation_speed
	weapon_length = GameVariables.knife_length
	
func process_inner():
	pass
	
func start_attack_inner():
	if atack_finished:
		swing_sword()
		
func swing_sword():
	if apply_atack == false:
		return 
		
	atack_finished = false
	var swing_angle = deg_to_rad(GameVariables.knife_swing_degree)
	var base_rotation = rotation
	var tween := create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_IN_OUT)
	if randf() < 0.5:
		apply_tween(tween, -swing_angle)
	else: 
		apply_tween(tween, swing_angle)
	await tween.finished
	atack_finished = true
	
func apply_tween(tween, swing_angle):
	tween.tween_property(self, "swing_offset", -swing_angle, 0.1)
	tween.tween_property(self, "swing_offset", swing_angle, 0.03)
	tween.tween_property(self, "swing_offset", 0, 0.3)

func _on_area_body_entered_inner(body):
	if angular_speed > GameVariables.knife_min_swing_speed and body is EnemyBase:
		var rnd = randf()
		var is_crit = rnd < GameVariables.player_crit_chance
		var calculated_damage = 0.0
		if is_crit and atack_finished == false:
			blood_particles.restart()
			calculated_damage = (damage + (angular_speed* 0.2)) * GameVariables.player_crit_multiplier
		else:
			calculated_damage = damage + (angular_speed * 0.2)
		
		if atack_finished: 
			calculated_damage = calculated_damage * GameVariables.player_rotation_atack_debuff
		body.take_damage(calculated_damage)
		return true
		
	return false

		
	
	
