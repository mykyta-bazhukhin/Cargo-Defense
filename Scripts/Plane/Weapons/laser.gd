extends Area2D
var direction = Vector2.UP
const speed = 1000
var damage = 5
var icon = "res://Sprites/UI stuff/laser icon.png"
var cooldown =  0.5



func _process(delta):
	position += direction * speed * delta


func _on_body_entered(body):
	if "hit" in body:
		body.hit(damage)
	queue_free()


func _on_timer_timeout_timeout():
	queue_free()
