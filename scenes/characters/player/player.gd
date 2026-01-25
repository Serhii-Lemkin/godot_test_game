extends CharacterBase
class_name Player

@onready var weapon_container: Control = $WeaponContainer
@export var playerSpeed = GameVariables.player_speed
var isAttacking: bool = false
func _ready():
	speed = GameVariables.player_speed
	Game.player = self
	facing_right = true
	add_to_group("player")
	equip_weapon(Weapon.WeaponType.KNIFE)
	
func equip_weapon(weapon: Weapon.WeaponType):
	var weapon_scene = null
	print(weapon)
	match weapon:
		Weapon.WeaponType.KNIFE:
			weapon_scene =  load("res://scenes/weapons/knife/knife.tscn").instantiate()
		Weapon.WeaponType.PISTOL:
			weapon_scene =  load("res://scenes/weapons/pistol/pistol.tscn").instantiate()

		Weapon.WeaponType.RIFLE:
			weapon_scene =  load("res://scenes/weapons/rifle/rifle.tscn").instantiate()
		Weapon.WeaponType.SHOTGUN:
			weapon_scene = load("res://scenes/weapons/shotgun/shotgun.tscn").instantiate()
	if weapon_scene != null:
		clear_children(weapon_container)
		weapon_container.add_child(weapon_scene)
		
func clear_children(node: Node):
	for child in node.get_children():
		child.queue_free()
		
func _physics_process(delta):
	weapon_facing_direction = get_joystick_direction("face")	
	var move_direction = get_joystick_direction("move")	
	if move_direction == Vector2.ZERO:
		face_direction(weapon_facing_direction)
	else:
		face_direction(move_direction)
	
	velocity = move_direction * playerSpeed
	move_and_slide()
	
func _input(event):
	if event.is_action_pressed("atack"):
		isAttacking = true
	if event.is_action_released("atack"):
		isAttacking = false
	
func get_joystick_direction(event: String)-> Vector2:
	var direction := Vector2.ZERO
	
	direction.x = Input.get_action_strength(event + "_right") - Input.get_action_strength(event + "_left")
	direction.y = Input.get_action_strength(event + "_down") - Input.get_action_strength(event + "_up")

	if direction.length() > 0:
		direction = direction.normalized()
		
	return direction
	
