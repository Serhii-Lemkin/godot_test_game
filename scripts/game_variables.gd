extends Node
#player
var player_speed := 200.0
var spawn_around_player_min_radius := 300.0
var spawn_around_player_max_radius := 5000.0
#weapons
var weapon_obsticle_speed_debuf = 20.0
#knife
var knife_scene_name := "res://scenes/weapons/knife/knife.tscn"
var knife_dmg := 10
var knife_length := 60
var knife_animation_speed := 10.0
var knife_offset_distance := 20.0
var knife_angle_correction := 90.0
var knife_rotation_speed := 10.0
var knife_min_swing_speed := 7.0
#player
var enemy_speed := 120.0
const enemy_spawn_chance := 0.20      
const max_enemies := 15
#scenes
var game_scene_name := "res://scenes/game/game.tscn"
var pause_menu_name := "res://scenes/ui/pause_menu/pause_menu.tscn"
var game_over_name := "res://scenes/ui/game_over/game_over.tscn"
var main_menu_name := "res://scenes/ui/main_menu/main_menu.tscn"
