extends Node2D

@onready var player: CharacterBody2D = null
var pause_overlay: CanvasLayer = null

func _ready():
	get_tree().paused = false
	
	
func _process(delta: float) -> void:
	pass
	
func go_to_main_menu():
	get_tree().change_scene_to_file("res://scenes/ui/main_menu/main_menu.tscn")
	
func game_over() -> void:
	var game_over_scene = preload("res://scenes/ui/game_over/game_over.tscn").instantiate()
	game_over_scene.process_mode = PROCESS_MODE_ALWAYS
	var overlay = CanvasLayer.new()
	overlay.add_child(game_over_scene)
	get_tree().current_scene.add_child(overlay)
	
func open_pause_menu() -> void:
	var pause_scene = preload("res://scenes/ui/pause_menu/pause_menu.tscn").instantiate()
	pause_overlay = CanvasLayer.new()
	pause_overlay.add_child(pause_scene)
	pause_scene.process_mode = PROCESS_MODE_ALWAYS
	get_tree().current_scene.add_child(pause_overlay)
	
func _input(event):
	if event.is_action_pressed("open_menu"):
		open_pause_menu()
	
	
	
	
	
	
