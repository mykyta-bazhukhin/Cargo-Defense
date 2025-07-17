extends Area2D
var direction = Vector2.UP
var speed = 200
var damage = 4


func _process(delta):
	position += direction * speed * delta

func _ready() -> void:
	pass
"""
func find_enemies_in_range(hit_body):
	var enemies_in_range: Array
	for enemy in tot_enemies:
		if (enemy.position.distance_to(hit_body.position) <= chain_range):
			enemies_in_range.append(enemy)
	#enemies_in_range.erase(hit_body)
	already_hit_dict.set(hit_body, 0)
	return enemies_in_range
"""

func _on_body_entered(body):
	if "hit" in body:
		body.hit(damage)
		visible = false
		$ChainLightning.chain(body)
		speed = 0
		disconnect("body_entered", _on_body_entered)
	else:
		queue_free()
	
	"""
	var end_pos
	var target_body
	var cur_tased_body = body
	if "hit" in cur_tased_body:
		for i in range(bounces):
			enemies_in_range = find_enemies_in_range(cur_tased_body)
			target_body = calculate_chain(cur_tased_body)
			if target_body == null:
				break
			target_body.hit(chain_damage)
			end_pos = target_body.position
			get_parent()._create_chain_lightning(cur_tased_body.position, end_pos)
			cur_tased_body = target_body
		body.hit(damage)
	queue_free()
	"""

func _on_timer_timeout_timeout():
	queue_free()
