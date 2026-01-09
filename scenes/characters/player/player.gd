extends CharacterBase

@export var playerSpeed = GameVariables.player_speed

func _ready():
	speed = GameVariables.player_speed
	Game.player = self
	facing_right = true
	add_to_group("player")

func _physics_process(delta):
	var direction := Vector2.ZERO

	direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	direction.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")

	if direction.length() > 0:
		direction = direction.normalized()
		
	face_direction(direction)
	velocity = direction * playerSpeed
	move_and_slide()
	
