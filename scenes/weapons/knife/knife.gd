extends WeaponBase

var swing_limit_reached = false

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



func _on_area_body_entered_inner(body):
	print(angular_speed) 
	if angular_speed > GameVariables.knife_min_swing_speed and body is EnemyBase:
		body.take_damage(damage)
	
	show_slowness_particles = true
	await get_tree().create_timer(0.5).timeout
	show_slowness_particles = false
