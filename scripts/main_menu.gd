extends Control
@onready var v_box_container: VBoxContainer = $VBoxContainer
@onready var start_button: Button = $VBoxContainer/start_button

func _ready() -> void:
	start_button.grab_focus()

func _process(delta: float) -> void:
	pass

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func _on_options_button_pressed() -> void:
	print("options")

func _on_exit_button_pressed() -> void:
	get_tree().quit()
