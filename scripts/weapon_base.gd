extends Node
class_name WeaponBase
@export var damage = 0.0
var animation_speed := 0.0
var offset_distance := 0.0
var angle_correction := 0.0
var rotation_speed := 1.0
var weapon_moving := false
var previous_rotation: float = 0.0
var angular_speed: float = 0.0

func _ready() -> void:
	pass

func draw(delta: float):
	if Game.player == null:
		return
	var dir := Game.player.weapon_facing_direction
	if dir.length() == 0:
		weapon_moving = false
		angular_speed = 0
		return 
		
	weapon_moving = true
	var target_rotation = dir.angle() + GameVariables.knife_angle_correction
	angular_speed = abs(shortest_angle_distance(self.rotation, previous_rotation) / delta)
	previous_rotation = self.rotation
	self.rotation = lerp_angle(self.rotation, target_rotation, rotation_speed * delta) 
	
func _process(delta: float) -> void:
	draw(delta)
	
func shortest_angle_distance(a: float, b: float) -> float:
	var diff = fmod(a - b + PI, 2 * PI) - PI
	return diff
