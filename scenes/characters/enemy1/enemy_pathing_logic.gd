extends CharacterBody2D

@export var speed = GameVaruables.enemy_speed
@onready var agent := $NavigationAgent2D as NavigationAgent2D


func _ready():
	pass

func _physics_process(_delta: float):
	if not Game.player:
		print("enemy cant fidnd t
		he player")
		return
		
	if agent.is_target_reached():
		return
		
	var current_position = global_position
	var next_position = agent.get_next_path_position()
	var new_velocity = current_position.direction_to(next_position) * speed
	if agent.avoidance_enabled:
		agent.set_velocity(new_velocity)
	else:	
		_on_navigation_agent_2d_velocity_computed(new_velocity)
		
	move_and_slide()
	
func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	velocity = safe_velocity
	
func make_path() -> void:
	agent.target_position = Game.player.global_position
	
func _on_timer_timeout():
	make_path()
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	print(body)
	print(body.get_groups())

	if body.is_in_group("player"):
		Game.game_over()
