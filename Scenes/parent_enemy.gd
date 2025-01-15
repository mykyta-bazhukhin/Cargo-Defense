extends CharacterBody2D
class_name ParentEnemy
var direction = Vector2.DOWN
var health
var speed


func hit(damage):
	health -= damage

func _process(delta):
	move_and_slide()
	velocity = Vector2.DOWN * speed
	
	if health <= 0:
		queue_free()
