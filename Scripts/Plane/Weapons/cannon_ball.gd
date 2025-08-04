extends Area2D
var direction = Vector2.UP
var speed = 1500
var damage = 600
var icon = "res://Sprites/UI stuff/Cannon shot icon.png"
var cooldown = 10

func _ready() -> void:
	$CannonExplosion.visible = false

func _process(delta):
	position += direction * speed * delta


func _on_body_entered(body):
	speed = 0
	$Sprite2D.visible = false
	$CannonExplosion.visible = true
	$CannonExplosion/AnimatedSprite2D.play("default")
	$CannonExplosion._explode_enemies(damage)
	disconnect("body_entered", _on_body_entered)

func _on_timer_timeout_timeout():
	queue_free()


func _on_explosion_timeout_timeout() -> void:
	queue_free()
