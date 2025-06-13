extends CharacterBody2D
var direction = Vector2.DOWN
var speed = 50
var health = 20
var scrap_value = 3
signal enemy_dead(pos, scrap_val)

func hit(damage):
	health -= damage
	
func _process(delta):
	move_and_slide()
	velocity = Vector2.DOWN * speed
	
	if health <= 0:
		enemy_dead.emit(position, scrap_value)
		queue_free()
