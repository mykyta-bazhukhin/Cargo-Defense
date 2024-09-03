extends CharacterBody2D
var direction = Vector2.DOWN
var speed = 0
var health = 20


func hit(damage):
	health -= damage

func _process(delta):
	move_and_slide()
	velocity = Vector2.DOWN * speed
	
	if health <= 0:
		queue_free()
