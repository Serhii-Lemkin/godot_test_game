extends FirearmBase


func face_direction() -> void:
	var angle := rotation
	var facing_right: bool = abs(wrapf(angle, -PI, PI)) < PI * 0.5
	sprite.flip_v = not facing_right
