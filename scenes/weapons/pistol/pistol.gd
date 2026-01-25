extends FirearmBase

@onready var pistol: Node2D = $"."
func ready_inner() -> void:
	damage = GameVariables.knife_dmg
	offset_distance = GameVariables.knife_offset_distance
	angle_correction = GameVariables.knife_angle_correction
	animation_speed = GameVariables.knife_animation_speed
	rotation_speed = GameVariables.knife_rotation_speed
	weapon_length = GameVariables.knife_length

func face_direction() -> void:
	var angle := rotation
	var facing_right: bool = abs(wrapf(angle, -PI, PI)) < PI * 0.5
	sprite.flip_v = not facing_right
