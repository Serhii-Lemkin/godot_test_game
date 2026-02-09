extends Node2D
class_name HealthBar
@onready var hitbox: CollisionShape2D = $"../CollisionShape2D"
@onready var area_colision_shape: CollisionShape2D = $"../Area2D/AreColisionShape"

@export var y_offset := -40
@export var hide_delay := 2.0
@export var damage_number_scene: PackedScene

@onready var bar: ProgressBar = $Bar
@onready var damage_layer: Node2D = $DamageLayer



var _owner_entity: EnemyBase
var _hide_timer: SceneTreeTimer

func _ready() -> void:
	pass

func setup(owner_entity: EnemyBase, max_health: float):
	_owner_entity = owner_entity
	bar.min_value = 0
	bar.max_value = owner_entity.max_health
	bar.value = owner_entity.current_health

func _process(delta: float) -> void:
	if _owner_entity:
		global_position = _owner_entity.global_position + Vector2(0, y_offset)
		
func apply_damage(amount: int, current_health: int, hit_position: Vector2):
	var tween = get_tree().create_tween()
	tween.tween_property(bar, "value", current_health, 0.2)
	spawn_damage_number(amount, hit_position)

func spawn_damage_number(amount: int, hit_position: Vector2):
	if not _owner_entity: 
		return
		
	var dmg_scene = preload("res://scenes/health_bar/damage_numbers/damage_numbers.tscn")
	var dmg_numbers_scene = dmg_scene.instantiate() as DamageNumbers
	damage_layer.get_parent().get_parent().get_parent().add_child(dmg_numbers_scene)
	
	dmg_numbers_scene.global_position = hit_position
	dmg_numbers_scene.setup(amount)
	
	var tween = get_tree().create_tween()
	tween.tween_property(dmg_numbers_scene, "position:y", dmg_numbers_scene.position.y + 30, 0.3)
	tween.tween_property(dmg_numbers_scene, "modulate:a", 0.0, 0.3)
	tween.finished.connect(dmg_numbers_scene.queue_free)
