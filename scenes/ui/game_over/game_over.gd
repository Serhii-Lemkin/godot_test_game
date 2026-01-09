extends Control
@onready var restart_button: Button = $VBoxContainer/restart_button

func _ready() -> void:
	restart_button.grab_focus() 
	get_tree().paused = true

func _on_restart_button_pressed() -> void:
	var tree := get_tree()
	tree.paused = false
	tree.change_scene_to_file(GameVariables.game_scene_name)
	Game.set_game_scene()

func _on_main_menu_button_pressed() -> void:
	Game.go_to_main_menu()
