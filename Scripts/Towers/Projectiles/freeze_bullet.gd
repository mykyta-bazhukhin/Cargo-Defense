extends Area2D

var SlowTimerScene = preload("res://Scenes/Status timers/slow_timer.tscn")

var direction = Vector2.UP
const speed = 1000
var damage = 50



func _process(delta):
	position += direction * speed * delta
	rotation += 10


func _on_body_entered(body):
	if "hit" in body:
		body.hit(damage)
		if body.get_node_or_null("SlowTimer") != null:
			body.get_node("SlowTimer").start()
		else:
			var slow_timer: Timer = SlowTimerScene.instantiate()
			slow_timer.wait_time = 1.2
			body.add_child(slow_timer)
	queue_free()


func _on_timer_timeout_timeout():
	queue_free()
