extends CanvasLayer
class_name TopUi

@onready var label: Label = $Control/Panel/MarginContainer/HBoxContainer/Label

var current_score: int = 0

func _ready() -> void:
	_on_score_changed(0) 
	Game.score_changed.connect(_on_score_changed)

func _process(delta: float) -> void:
	pass
	
func _on_score_changed(amount: int):
	current_score += amount
	label.text = "Score: %d" % current_score
