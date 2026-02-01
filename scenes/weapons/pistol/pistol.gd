extends FirearmBase

@onready var pistol: Node2D = $"."
func ready_inner() -> void:
	damage = GameVariables.pistol_damage
	offset_distance = GameVariables.pistol_offset_distance
	angle_correction = GameVariables.pistol_angle_correction
	rotation_speed = GameVariables.pistol_rotation_speed
	weapon_length = GameVariables.pistol_length
	bullet_speed = GameVariables.pistol_bullet_speed
	cooldown = GameVariables.pistol_cooldown

func face_direction() -> void:
	var angle := rotation
	var facing_right: bool = abs(wrapf(angle, -PI, PI)) < PI * 0.5
	sprite.flip_v = not facing_right
