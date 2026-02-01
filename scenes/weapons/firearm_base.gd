extends WeaponBase
class_name FirearmBase
const plain_bullet = preload("uid://ec107uuwrimo")
@onready var bullet_point: Node2D = $BulletPoint

var bullet_speed: float = 100.0;
var cooldown: float = 1.0;
var is_on_cooldown: bool = false

func _ready() -> void:
	super._ready()
	
func _process(delta: float) -> void:
	super._process(delta)

func start_attack_inner() -> void:
	if !is_on_cooldown:
		is_on_cooldown = true
		var bullet: PlainBullet = plain_bullet.instantiate()
		bullet.direction = rotation
		bullet.start_rotation = rotation
		bullet.start_position = bullet_point.global_position
		bullet.damage = damage
		bullet.speed = bullet_speed
		Game.player.get_parent().add_child(bullet)
		await get_tree().create_timer(cooldown).timeout
		is_on_cooldown = false
