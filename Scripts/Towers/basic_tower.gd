extends BaseTower

signal shoot_bullet(pos, bullet_type) 

func _ready() -> void:
	super()
	connect("shoot_bullet", Callable(get_node("../../Projectiles"), "_on_shoot_projectile"))

func _on_tower_shoot_timer_timeout() -> void:
	shoot_bullet.emit(position, "Bullet")
