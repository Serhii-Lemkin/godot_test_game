extends Node2D
class_name WeaponBase

@onready var area := $Area2D
@onready var gpu_particles_2d: GPUParticles2D = $SlownessParticless
@onready var blood_particles: GPUParticles2D = $BloodParticles

@export var damage = 0.0

var animation_speed := 0.0
var offset_distance := 0.0
var angle_correction := 0.0
var rotation_speed := 1.0
var previous_rotation: float = 0.0
var angular_speed: float
var weapon_length: float = 0.0
var weapon_slowed := false
var show_slowness_particles := false
var show_blood_particles := false

func _ready() -> void:
	pass

func draw(delta: float):
	if Game.player == null:
		return
		
	var dir = Game.player.weapon_facing_direction
	if dir.length() == 0:
		weapon_slowed = check_is_weapon_stuck(rotation, rotation)
		return
		
	var target_rotation = dir.angle() 
	var next_rotation = lerp_angle(rotation, target_rotation, rotation_speed * delta)
	
	weapon_slowed = check_is_weapon_stuck(rotation, rotation)
	if weapon_slowed:
		next_rotation = lerp_angle(rotation, target_rotation, (rotation_speed / GameVariables.weapon_obsticle_speed_debuf) * delta)
		
	rotation = next_rotation
	angular_speed = abs(shortest_angle_distance(rotation, previous_rotation)) / delta
	previous_rotation = rotation

func check_is_weapon_stuck(next_rotation: float, current_rotation: float) -> bool:
	var from = global_position
	var to = from + Vector2.RIGHT.rotated(next_rotation) * weapon_length
	var space_state = get_viewport().get_world_2d().direct_space_state
	var current_scene = get_tree().current_scene
	var wrapper := current_scene.get_node_or_null("y_sorting_wrapper")
	var exclude_list = [self, Game.player]
	if wrapper:
		for child in wrapper.get_children():
			if child is EnemyBase:
				exclude_list.append(child)
				
	var query = PhysicsRayQueryParameters2D.create(from, to)
	query.exclude = exclude_list
	query.collide_with_bodies = true
	query.collide_with_areas = false
	return not space_state.intersect_ray(query).is_empty()
	
func _on_area_body_entered(body):
	var valid_colision = _on_area_body_entered_inner(body)
	if valid_colision:
		blood_particles.restart()
	
func _process(delta: float) -> void:
	draw(delta)
	process_inner()
	gpu_particles_2d.emitting = weapon_slowed or show_slowness_particles
	#blood_particles.emitting = show_blood_particles
	
	
func shortest_angle_distance(a: float, b: float) -> float:
	var diff = fmod(a - b + PI, 2 * PI) - PI
	return diff
	
func process_inner(): pass
	
func _on_area_body_entered_inner(body): pass 
