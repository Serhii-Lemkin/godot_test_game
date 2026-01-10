extends CharacterBase
class_name  EnemyBase

@onready var health_bar: HealthBar = $HealthBar
@onready var agent := $NavigationAgent2D as NavigationAgent2D
var knockback_velocity: Vector2 = Vector2.ZERO
var kill_score: int

func _ready() -> void:
	pass

func instansiate():
	instansiate_inner()
	health_bar.setup(self, max_health)
	
func _process(delta: float) -> void:
	pass
	
func _physics_process(_delta: float):
	if not Game.player:
		print("enemy cant fisnd the player")
		return
		
	if agent.is_target_reached():
		return
		
	var current_position = global_position
	var next_position = agent.get_next_path_position()
	var new_velocity = current_position.direction_to(next_position) * speed
	var knocked = false
	if knockback_velocity.length() > 0:
		new_velocity += knockback_velocity
		knockback_velocity = knockback_velocity.move_toward(Vector2.ZERO, GameVariables.enemy_knockback_friction * _delta)
		knocked = true
	
	if agent.avoidance_enabled:
		agent.set_velocity(new_velocity)
		if not knocked: face_direction(new_velocity)
	else:	
		_on_navigation_agent_2d_velocity_computed(new_velocity)
		if not knocked: face_direction(velocity)
		
	move_and_slide()
	
func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	velocity = safe_velocity
	
func make_path() -> void:
	agent.target_position = Game.player.global_position
	
func _on_timer_timeout():
	make_path()
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		Game.game_over()
		
func take_damage(dmg: float)-> void:
	var rounded_dmg = int(round(dmg)) 
	var health_after_dmg = self.current_health - rounded_dmg
	if health_after_dmg <= 0: 
		death_and_despawn()
	else:
		if self.health_bar:
			self.current_health = max(health_after_dmg, 0)
			self.health_bar.apply_damage(rounded_dmg, self.current_health, self.global_position)
		knock_back()
			
func knock_back():
	if Game.player:
		var direction = (global_position - Game.player.global_position).normalized()
		knockback_velocity = direction * GameVariables.enemy_knockback_strength
	
	
func death_and_despawn():
	
	Game.add_score(kill_score)
	self.queue_free()
	
func instansiate_inner(): pass
