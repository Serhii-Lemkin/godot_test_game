@tool 
extends Control

const SPRITE_SIZE = Vector2(128, 128)

@export var bck_color: Color
@export var line_color: Color
@export var selected_color: Color
@export var deadzone := 0.3
@export var outer_radius: int = 256
@export var inner_radius: int = 64
@export var line_width: int = 4 
var options : Array[Weapon.WeaponType] = [
	Weapon.WeaponType.KNIFE, 
	Weapon.WeaponType.PISTOL, 
	Weapon.WeaponType.SHOTGUN, 
	Weapon.WeaponType.RIFLE]
	
var select = 0

var weapon_textures := {
	Weapon.WeaponType.KNIFE: preload("res://textures/weapons/weapons_small/knife_small.png"),
	Weapon.WeaponType.PISTOL: preload("res://textures/weapons/weapons_small/pistol_small.png"),
	Weapon.WeaponType.SHOTGUN: preload("res://textures/weapons/weapons_small/shotgun_small.png"),
	Weapon.WeaponType.RIFLE: preload("res://textures/weapons/weapons_small/rifle_small.png")
}

func _draw() -> void:
	var offset = SPRITE_SIZE / -2
	draw_circle(Vector2.ZERO, outer_radius, bck_color)
	draw_arc(Vector2.ZERO, inner_radius, 0, TAU, 128, line_color, line_width, true)
	len(options)
	for i in range(len(options)):
		var rads = TAU * i / (len(options))
		var point = Vector2.from_angle(rads)
		draw_line(
			point * inner_radius, 
			point * outer_radius,
			line_color,
			line_width, 
			true
		)
		
	for i in range(len(options)):
		var start_rads = (TAU * (i - 1)) / (len(options))
		var end_rads = (TAU * (i)) / (len(options))
		var mid_rads = (start_rads + end_rads) / 2 * -1
		var radius_mid = (inner_radius + outer_radius) / 2.0
		if select == i:
			var points_per_arch = 32
			var points_inner = PackedVector2Array()
			var points_outer = PackedVector2Array()
			for j in range(points_per_arch + 1):
				var angle = start_rads + j * (end_rads - start_rads)/ points_per_arch
				points_inner.append(inner_radius * Vector2.from_angle(TAU-angle))
				points_outer.append(outer_radius * Vector2.from_angle(TAU-angle))
				
			points_outer.reverse()
			draw_polygon(
				points_inner + points_outer, 
				PackedColorArray([selected_color])
			)
			
		var draw_pos = radius_mid * Vector2.from_angle(mid_rads) + offset
		var tex = weapon_textures[options[i]]
		draw_texture(tex, draw_pos)

func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		return
	var dir = get_stick_direction()

	if dir != Vector2.ZERO and visible:
		var new_select = get_slice_from_direction(dir)
		if new_select != select:
			select = new_select
			Game.player.equip_weapon(options[select])
	
	queue_redraw()

func get_stick_direction() -> Vector2:

	var dir = Vector2(
		Input.get_action_strength("face_right") - Input.get_action_strength("face_left"),
		Input.get_action_strength("face_down") - Input.get_action_strength("face_up")
	)

	return dir if dir.length() >= deadzone else Vector2.ZERO
	
func get_slice_from_direction(dir: Vector2) -> int:
	if dir == Vector2.ZERO:
		return -1

	var angle = atan2(-dir.y, dir.x)
	angle = fposmod(angle, TAU)
	angle = fposmod(angle + PI / 2, TAU)

	var slice_size = TAU / options.size()
	return int(angle / slice_size)
