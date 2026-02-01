extends FirearmBase

func ready_inner() -> void:
	damage = GameVariables.rifle_damage
	offset_distance = GameVariables.rifle_offset_distance
	angle_correction = GameVariables.rifle_angle_correction
	rotation_speed = GameVariables.rifle_rotation_speed
	weapon_length = GameVariables.rifle_length
	bullet_speed = GameVariables.rifle_bullet_speed
	cooldown = GameVariables.rifle_cooldown
	
func face_direction() -> void:
	var angle := rotation
	var facing_right: bool = abs(wrapf(angle, -PI, PI)) < PI * 0.5
	sprite.flip_v = not facing_right
	if sprite.flip_v:
		sprite.offset.y = -85.0
	else:
		sprite.offset.y = 0.0
