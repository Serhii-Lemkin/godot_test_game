extends CharacterBase
class_name Player

@onready var weapon_container: Control = $WeaponContainer
var playerSpeed = GameVariables.player_speed
var dodge_speed = GameVariables.player_dodge_speed
var dodge_time = GameVariables.player_dodge_time
var isAttacking: bool = false
var do_dodge: bool = false
var dodge_allowed: bool = true
var dodge_cooldown: float = GameVariables.player_dodge_cooldown

signal damage_taken(amount: int)

func _ready():
	speed = GameVariables.player_speed
	Game.player = self
	facing_right = true
	add_to_group("player")
	equip_weapon(Weapon.WeaponType.KNIFE)
	
func equip_weapon(weapon: Weapon.WeaponType):
	var weapon_scene = null
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
	var move_direction = get_joystick_direction("move")	
	weapon_facing_direction = get_joystick_direction("face")	
	if do_dodge and dodge_allowed:
		var dir: Vector2 = Vector2.ZERO
		if move_direction == Vector2.ZERO:
			if sprite.flip_h:
				dir = Vector2.RIGHT
			else:
				dir = Vector2.LEFT
		else:
			dir = move_direction
		velocity = dir * dodge_speed
	else:
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
	if event.is_action_pressed("leap"):
		if dodge_allowed:
			do_dodge = true
			get_tree().create_timer(dodge_time).timeout.connect(reset_trigger_dodge)
	
func reset_trigger_dodge():
	do_dodge = false
	dodge_allowed = false
	get_tree().create_timer(dodge_cooldown).timeout.connect(reset_dodge_cooldown)
	
func reset_dodge_cooldown():
	dodge_allowed = true
	
func get_joystick_direction(event: String)-> Vector2:
	var direction := Vector2.ZERO
	
	direction.x = Input.get_action_strength(event + "_right") - Input.get_action_strength(event + "_left")
	direction.y = Input.get_action_strength(event + "_down") - Input.get_action_strength(event + "_up")

	if direction.length() > 0:
		direction = direction.normalized()
		
	return direction
	
func take_damage(amount: int):
	damage_taken.emit(amount)
	print(amount)
	
