extends SceneBase
@onready var y_sorting_wtapper: Node2D = $y_sorting_wtapper

func _ready() -> void:
	pass 

func _on_timer_timeout() -> void:
	if is_spawn_allowed():
		spawn_enemy()
		
func is_spawn_allowed() -> bool:
	var count = get_enemy_count()
	if count >= GameVariables.max_enemies:
		return false;
		
	if count < 4:
		return true
		
	if randf() > GameVariables.enemy_spawn_chance:
		return false
		
	return true
	
func get_enemy_count() -> int:
	var count := 0
	for child in y_sorting_wtapper.get_children():
		if child is Enemy:
			count += 1
	return count
	
func spawn_enemy():
	var pos = get_valid_spawn_position(Game.player.global_position)
	if pos == Vector2.ZERO:
		return
		
	var enemy_scene =  preload("res://scenes/characters/enemy1/enemy.tscn")
	var enemy := enemy_scene.instantiate()
	enemy.global_position = pos
	y_sorting_wtapper.add_child(enemy)
	
func random_point_around(origin: Vector2, min_radius: float, max_radius: float) -> Vector2:
	var angle = randf() * TAU
	var radius = randf_range(min_radius, max_radius)
	return origin + Vector2(cos(angle), sin(angle)) * radius

func get_valid_spawn_position(player_pos: Vector2) -> Vector2:
	var nav_map := get_world_2d().navigation_map
	var attempts := 12
	for i in attempts:
		var candidate = random_point_around(player_pos, GameVariables.spawn_around_player_min_radius, GameVariables.spawn_around_player_min_radius)

		var nav_point = NavigationServer2D.map_get_closest_point(nav_map, candidate)
		if nav_point.distance_to(player_pos) >= GameVariables.spawn_around_player_min_radius:
			return nav_point

	return Vector2.ZERO
