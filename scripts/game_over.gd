extends Control
@onready var v_box_container: VBoxContainer = $VBoxContainer
@onready var restart_button: Button = $VBoxContainer/restart_button

func _ready() -> void:
	restart_button.grab_focus() 


func _process(delta: float) -> void:
	pass


func _on_restart_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_main_menu_button_pressed() -> void:
	Game.go_to_main_menu()
