extends CharacterBody2D

class_name CharacterBase
@onready var sprite: Sprite2D = $Sprite2D
@export var speed = 0
@export var facing_right: bool
@export var weapon_facing_direction: Vector2

var max_health: int
var current_health: int
var crit_chance: float
var crit_multiplier: float

func _ready() -> void:
	pass 

func face_direction(direction: Vector2) -> void:
	if direction.x == 0:
		return
		
	var moving_right = direction.x > 0
	if facing_right:
		sprite.flip_h = not moving_right  
	else:
		sprite.flip_h = moving_right   
