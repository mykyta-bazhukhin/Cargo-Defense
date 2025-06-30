extends Area2D


@export var direction: Vector2 = Vector2.UP
var speed: int = 500
var damage: int = 15
var is_dead: bool = false


var target_array = []

func _ready():
	$RocketExplosionSprite.visible = false
	$RocketSprite.visible = true
	


func _process(delta):
	if (is_dead == false):
		rotation = direction.angle()
		position += direction * speed * delta
		if (target_array.size() > 0):
			#look_at(target_array[min_enemy].global_position)
			var tween = get_tree().create_tween()
			tween.tween_property(self, "direction", (find_min_dist_enemy_pos() - position).normalized(), 0.3)
func find_min_dist_enemy_pos():
	var min_dist_enemy = target_array[0]
	var cur_dist = 0
	var min_dist = position.distance_to(target_array[0].position)
	for i in target_array.size():
		cur_dist = position.distance_to(target_array[i].position)
		if (cur_dist <= min_dist):
			min_dist = cur_dist
			min_dist_enemy = target_array[i]
	return min_dist_enemy.position
	

func _on_detection_range_body_entered(body):
	target_array.append(body)
	

func _on_detection_range_body_exited(body):
	target_array.erase(body)
	


func _on_body_entered(body):
	if "hit" in body:
		body.hit(damage)
	is_dead = true
	speed = 0
	$AnimationPlayer.play("Rocket_explosion")
	


func _on_timer_timeout_timeout():
	is_dead = true
	speed = 0
	$AnimationPlayer.play("Rocket_explosion")
