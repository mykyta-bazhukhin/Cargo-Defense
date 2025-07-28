extends CharacterBody2D
class_name BaseEnemy
@export var direction = Vector2.DOWN
@export var speed : int
@export var health : int
@export var scrap_value : int 
signal enemy_dead(pos, scrap_val)
signal dead()

func hit(damage):
	health -= damage
	$HitFlashAnimation.play("hit")
	if health <= 0:
		queue_free()
		#emit_signal("dead")

func _process(delta):
	move_and_slide()
	velocity = Vector2.DOWN * speed
