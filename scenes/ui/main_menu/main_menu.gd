extends Control

@onready var start_button: Button = $VBoxContainer/start_button

func _ready() -> void:
	self.process_mode = Node.PROCESS_MODE_ALWAYS
	start_button.grab_focus()

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file(GameVariables.game_scene_name)
	Game.set_game_scene()

func _on_options_button_pressed() -> void:
	print("options")

func _on_exit_button_pressed() -> void:
	get_tree().quit()
