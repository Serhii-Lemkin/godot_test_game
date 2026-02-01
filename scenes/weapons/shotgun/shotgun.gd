extends FirearmBase

var spread_deg = 30.0

func ready_inner() -> void:
	damage = GameVariables.shotgun_damage
	offset_distance = GameVariables.shotgun_offset_distance
	angle_correction = GameVariables.shotgun_angle_correction
	rotation_speed = GameVariables.shotgun_rotation_speed
	weapon_length = GameVariables.shotgun_length
	bullet_speed = GameVariables.shotgun_bullet_speed
	cooldown = GameVariables.shotgun_cooldown

func start_attack_inner() -> void:
	if !is_on_cooldown:
		for i in range(8):
			is_on_cooldown = true
			var bullet: PlainBullet = plain_bullet.instantiate()
			var offset = deg_to_rad(randf_range(-spread_deg / 2, spread_deg / 2))
			var final_rotation = rotation + offset
			bullet.direction = final_rotation
			bullet.start_rotation = final_rotation
			bullet.start_position = bullet_point.global_position
			bullet.damage = damage
			bullet.speed = bullet_speed
			get_parent().add_child(bullet)
			
		await get_tree().create_timer(cooldown).timeout
		is_on_cooldown = false

func face_direction() -> void:
	var angle := rotation
	var facing_right: bool = abs(wrapf(angle, -PI, PI)) < PI * 0.5
	sprite.flip_v = not facing_right
