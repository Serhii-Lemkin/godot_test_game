extends CanvasLayer
class_name TopUi
@onready var selection_wheel: Control = $SelectionWheel

@onready var label: Label = $Control/Panel/MarginContainer/HBoxContainer/Label

var current_score: int = 0
var wheel_open = false
func _ready() -> void:
	_on_score_changed(0) 
	Game.score_changed.connect(_on_score_changed)
	selection_wheel.visible = false

func _process(delta: float) -> void:
	pass
	
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
