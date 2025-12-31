extends Control

@onready var resume_button: Button = $VBoxContainer/resume_button

func _ready() -> void:
	get_tree().paused = true
	resume_button.grab_focus()

func _process(delta: float) -> void:
	pass

func _on_main_menu_button_pressed() -> void:
	get_tree().paused = true
	Game.go_to_main_menu()


func _on_resume_button_pressed() -> void:
	get_tree().paused = false
	get_parent().queue_free()
