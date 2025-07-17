extends Area2D

var end_pos
var start_pos
var bounces = 2
var chain_damage = 300
var chain_range
var tot_enemies: Array
var enemies_in_range: Array
var already_hit_dict: Dictionary
signal ready_for_shader(end_pos, start_pos)

func _ready() -> void:
	tot_enemies = get_parent().get_parent().get_parent().get_enemies()
	chain_range = $LightningRangeVisual.shape.radius
	visible = false
	
	#ready_for_shader.emit(end_pos, start_pos)


func find_enemies_in_range_of(body):
	for enemy in tot_enemies:
		if (enemy.position.distance_to(body.position) <= chain_range):
			enemies_in_range.append(enemy)
	#enemies_in_range.erase(hit_body)
	already_hit_dict.set(body, 0)
	return enemies_in_range

func calculate_closest_to(body):
	enemies_in_range = find_enemies_in_range_of(body)
	if enemies_in_range.size() > bounces+1:
		var min_dist_body = null
		var min_dist = body.position.distance_to(enemies_in_range[0].position)
		var last_min_dist = body.position.distance_to(enemies_in_range[0].position)
		for enemy in enemies_in_range:
			if enemy in already_hit_dict:
				continue
			min_dist = min(body.position.distance_to(enemy.position), min_dist)
			if last_min_dist != min_dist:
				min_dist_body = enemy
				last_min_dist = min_dist
		#ready_for_shader.emit(min_dist_body.position)
		return min_dist_body
	return null

func _chain_enemies(hit_body) -> void:
	#do calculate closest
	#get the body out of there
	#hit it and visualize it
	#put it back into the calculate closest
	#repeat this until out of bounces or out of bodies
	visible = true


func _on_body_entered(body: Node2D) -> void:
	if "hit" in body:
		enemies_in_range.append(body)

func _on_body_exited(body: Node2D) -> void:
	if "hit" in body:
		enemies_in_range.erase(body)
