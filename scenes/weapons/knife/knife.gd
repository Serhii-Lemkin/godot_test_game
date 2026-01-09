extends WeaponBase

@onready var area := $Area2D

func _ready() -> void:
	area.connect("body_entered", Callable(self, "_on_area_body_entered"))
	damage = GameVariables.knife_dmg
	offset_distance = GameVariables.knife_offset_distance
	angle_correction = GameVariables.knife_angle_correction
	animation_speed = GameVariables.knife_animation_speed
	rotation_speed = GameVariables.knife_rotation_speed

func _on_area_body_entered(body):
	if angular_speed > GameVariables.knife_min_swing_speed and weapon_moving and body is EnemyBase:
		body.take_damage(damage)
