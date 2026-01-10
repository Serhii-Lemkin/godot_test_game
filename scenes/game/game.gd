extends Node2D
class_name SceneBase

@onready var player: Player = null

signal score_changed(new_score: int)

var current_scene := ''

func _ready():
	get_tree().paused = false
	
func set_game_scene():
	set_starting_scene()
	var tree = get_tree()
	tree.change_scene_to_file(current_scene)
	tree.paused = false
	
func go_to_main_menu():
	get_tree().change_scene_to_file(GameVariables.main_menu_name)
	
func game_over() -> void:
	var game_over_scene = load(GameVariables.game_over_name).instantiate()
	game_over_scene.process_mode = PROCESS_MODE_ALWAYS
	var overlay = CanvasLayer.new()
	overlay.add_child(game_over_scene)
	get_tree().current_scene.add_child(overlay)
	
func open_pause_menu() -> void:
	var pause_scene = load(GameVariables.pause_menu_name).instantiate()
	var pause_overlay = CanvasLayer.new()
	pause_overlay.add_child(pause_scene)
	pause_scene.process_mode = PROCESS_MODE_ALWAYS
	get_tree().current_scene.add_child(pause_overlay)
	
func _input(event):
	if event.is_action_pressed("open_menu"):
		open_pause_menu()
		
func set_starting_scene():
	current_scene = "res://scenes/level1/level1.tscn"
	
var score: int = 0

func add_score(amount: int) -> void:
	score_changed.emit(amount)
	
	
	
	
	
	
