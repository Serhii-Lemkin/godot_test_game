extends EnemyBase

class_name Enemy

func instansiate_inner():
	facing_right = false
	speed = GameVariables.enemy_speed
	max_health = GameVariables.enemy_max_health
	current_health = GameVariables.enemy_max_health
	kill_score = GameVariables.enemy_kill_score
	
