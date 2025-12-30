extends Node2D

@onready var player: CharacterBody2D = null

func _ready():
	pass
	
func _process(delta: float) -> void:
	pass
	
func go_to_main_menu():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	
func game_over() -> void:	get_tree().call_deferred("change_scene_to_file", "res://scenes/game_over.tscn")
