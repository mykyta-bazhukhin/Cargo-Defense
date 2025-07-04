extends Area2D
var direction = Vector2.UP
const speed = 200
var damage = 4
var bounces = 2
var chain_damage = 300
var chain_range = 3000
var tot_enemies 
var enemies_in_range: Array
var already_hit_dict: Dictionary

func _process(delta):
	position += direction * speed * delta

func _ready() -> void:
	pass

func find_enemies_in_range(cur_body):
	var enemies_in_range: Array
	tot_enemies = get_parent().get_parent()._get_total_enemies()
	for enemy in tot_enemies:
		if (enemy.position.distance_to(cur_body.position) <= chain_range):
			enemies_in_range.append(enemy)
	#enemies_in_range.erase(cur_body)
	already_hit_dict.set(cur_body, 0)
	return enemies_in_range

func calculate_chain(cur_body):
	if enemies_in_range.size() != 0:
		var min_dist_body = null
		var min_dist = cur_body.position.distance_to(enemies_in_range[0].position)
		var last_min_dist = cur_body.position.distance_to(enemies_in_range[0].position)
		for body in enemies_in_range:
			if body in already_hit_dict:
				continue
			min_dist = min(cur_body.position.distance_to(body.position), min_dist)
			if last_min_dist != min_dist:
				min_dist_body = body
				last_min_dist = min_dist
		#ready_for_shader.emit(min_dist_body.position)
		return min_dist_body
	return null
	

func _on_body_entered(body):
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


func _on_timer_timeout_timeout():
	queue_free()
