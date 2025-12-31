extends CharacterBody2D

@export var playerSpeed = GameVaruables.player_speed

func _ready():
	Game.player = self
	add_to_group("player")

func _physics_process(delta):
	var direction := Vector2.ZERO

	direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	direction.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")

	if direction.length() > 0:
		direction = direction.normalized()

	velocity = direction * playerSpeed
	move_and_slide()

	
