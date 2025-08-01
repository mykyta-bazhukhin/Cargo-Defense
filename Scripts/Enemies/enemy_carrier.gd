extends CharacterBody2D
var direction = Vector2.DOWN
var speed = 50
var health = 20
var scrap_value = 3
signal enemy_dead(pos, scrap_val)
signal dead()

func hit(damage):
	health -= damage
	$HitFlashAnimation.play("hit")

func _process(delta):
	move_and_slide()
	velocity = Vector2.DOWN * speed
	
	if health <= 0:
		enemy_dead.emit(position, scrap_value)
		queue_free()
		#emit_signal("dead")

func _on_dead() -> void:
	$CollisionShape2D.disabled = true
	speed = 0
	$DeathDelayTimer.start()
	disconnect("dead", _on_dead)

func _on_death_delay_timer_timeout() -> void:
	enemy_dead.emit(position, scrap_value)
	queue_free()
