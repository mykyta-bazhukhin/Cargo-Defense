extends "res://Inheritence Scenes/base_tower.gd"

var FreezeBulletScene = preload("res://Scenes/freeze_bullet.tscn")
signal shoot_freeze_bullet(pos)

func _ready() -> void:
	super()
	connect("shoot_freeze_bullet", Callable(get_node("../../Projectiles"), "_on_shoot_projectile"))


func _on_tower_shoot_timer_timeout() -> void:
	shoot_freeze_bullet.emit(position, FreezeBulletScene)
