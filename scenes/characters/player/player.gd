extends CharacterBase
class_name Player

@export var playerSpeed = GameVariables.player_speed

func _ready():
	speed = GameVariables.player_speed
	Game.player = self
	facing_right = true
	add_to_group("player")

func _physics_process(delta):
	weapon_facing_direction = get_joystick_direction("face")	
	var move_direction = get_joystick_direction("move")	
	face_direction(move_direction)
	velocity = move_direction * playerSpeed
	move_and_slide()
	
func get_joystick_direction(event: String)-> Vector2:
	var direction := Vector2.ZERO
	
	direction.x = Input.get_action_strength(event + "_right") - Input.get_action_strength(event + "_left")
	direction.y = Input.get_action_strength(event + "_down") - Input.get_action_strength(event + "_up")

	if direction.length() > 0:
		direction = direction.normalized()
		
	return direction
	
