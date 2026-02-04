extends CanvasLayer
class_name TopUi
@onready var selection_wheel: Control = $SelectionWheel
@onready var label: Label = $Control/Panel/MarginContainer/HBoxContainer/CenterContainer3/Label
@onready var progress_bar: ProgressBar = $Control/Panel/MarginContainer/HBoxContainer/CenterContainer2/ProgressBar
@onready var health_bar_label: Label = $Control/Panel/MarginContainer/HBoxContainer/CenterContainer2/HealthLabel

var max_health := GameVariables.player_health
var inner_health : int
var current_score: int = 0
var wheel_open = false

func _ready() -> void:
	Game.score_changed.connect(_on_score_changed)
	Game.player.damage_taken.connect(_on_damage_taken)
	selection_wheel.visible = false
	inner_health = max_health
	_on_score_changed(0) 
	_on_damage_taken(0) 
	get_tree().create_timer(1).timeout.connect(after_ready)

func after_ready():
	pass
	
func _on_damage_taken(amount: int) -> void:
	inner_health = max(inner_health - amount, 0)
	progress_bar.max_value = max_health
	progress_bar.value = inner_health
	health_bar_label.text = "%d/%d" % [inner_health, max_health]
	if inner_health <= 0:
		Game.game_over()

func _on_score_changed(amount: int):
	current_score += amount
	label.text = "Score: %d" % current_score

func _input(event):
	if event.is_action_pressed("weapon_wheel"):
		open_wheel()
	elif event.is_action_released("weapon_wheel"):
		close_wheel()
		
func open_wheel():
	if wheel_open:
		return

	wheel_open = true
	selection_wheel.visible = true

	# Godot 4.5 pause fix
	get_tree().paused = true
	process_mode = Node.PROCESS_MODE_ALWAYS

func close_wheel():
	if not wheel_open:
		return

	wheel_open = false
	selection_wheel.visible = false
	get_tree().paused = false
	process_mode = Node.PROCESS_MODE_INHERIT
