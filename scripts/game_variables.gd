extends Node
#player
var player_speed := 200.0
var player_crit_chance:= 0.1
var player_crit_multiplier := 2.0
var player_rotation_atack_debuff := 0.2
var spawn_around_player_min_radius := 400.0
var spawn_around_player_max_radius := 5000.0
#weapons
var weapon_obsticle_speed_debuf = 20.0
#knife
var knife_scene_name := "res://scenes/weapons/knife/knife.tscn"
var knife_dmg := 7
var knife_length := 60
var knife_animation_speed := 10.0
var knife_offset_distance := 20.0
var knife_angle_correction := 90.0
var knife_rotation_speed := 10.0
var knife_min_swing_speed := 7.0
var knife_swing_degree := 25.0
#pistol

#enemy
var enemy_max_health :int = 50
var enemy_kill_score :int = 20
var enemy_speed := 130.0
const enemy_spawn_chance := 0.24      
const max_enemies := 30
var enemy_knockback_strength := 600.0
var enemy_knockback_friction := 900.0
#scenes
var game_scene_name := "res://scenes/game/game.tscn"
var pause_menu_name := "res://scenes/ui/pause_menu/pause_menu.tscn"
var game_over_name := "res://scenes/ui/game_over/game_over.tscn"
var main_menu_name := "res://scenes/ui/main_menu/main_menu.tscn"
var health_view_scene_name := "res://scenes/health_bar/health_bar.tscn"
