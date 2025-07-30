extends CharacterBody2D
class_name BaseEnemy
@export var direction = Vector2.DOWN
@export var speed : int
@export var health : int
@export var scrap_value : int 
var in_range_targets : Array
var damage = 30
signal enemy_dead(pos, scrap_val)
signal dead()

func hit(damage):
	health -= damage
	$HitFlashAnimation.stop()
	$HitFlashAnimation.play("hit")
	if health <= 0:
		queue_free()
		#emit_signal("dead")

func _process(delta):
	move_and_slide()
	velocity = Vector2.DOWN * speed


func _on_attack_range_body_entered(body: Node2D) -> void:
	in_range_targets.append(body)
	if in_range_targets.size() == 1:
		$AnimatedSprite2D.animation = "Attacking"
		speed = 0
		$AttackTimer.start()


func _on_attack_range_body_exited(body: Node2D) -> void:
	in_range_targets.erase(body)
	if in_range_targets.size() == 0:
		$AnimatedSprite2D.animation = "Moving"
		speed = 100
		$AttackTimer.stop()


func _on_attack_timer_timeout() -> void:
	if in_range_targets[0] != null:
		if "hit" in in_range_targets[0]:
			in_range_targets[0].hit(damage)
