extends Area2D

var end_pos
var start_pos
var bounces = 1
var chain_damage = 300
var chain_range
var tot_enemies: Array
var enemies_in_range: Array
var already_hit_dict: Dictionary
signal ready_for_shader(end_pos, start_pos)

func _ready() -> void:
	tot_enemies = get_parent().get_parent().get_parent()._get_enemies()
	chain_range = $LightningRangeVisual.shape.radius
	#visible = false
	
	#ready_for_shader.emit(end_pos, start_pos)


func find_enemies_in_range_of(body, body_position):
	var body_to_enemy_distance
	var enemy_position
	for enemy in tot_enemies:
		if (enemy != null and enemy not in already_hit_dict and enemy.position.distance_to(body_position) <= chain_range):
			enemy_position = enemy.position
			body_to_enemy_distance = enemy.position.distance_to(body_position)
			enemies_in_range.append(enemy)
			print("enemy added")
	#enemies_in_range.erase(hit_body)

func calculate_closest_to(body, body_position):
	find_enemies_in_range_of(body, body_position)
	if enemies_in_range.size() == 0:
		return null
	var min_dist_body = enemies_in_range[0]
	var min_dist = body.position.distance_to(enemies_in_range[0].position)
	var last_min_dist = body.position.distance_to(enemies_in_range[0].position)
	for enemy in enemies_in_range:
		min_dist = min(body.position.distance_to(enemy.position), min_dist)
		if last_min_dist != min_dist:
			min_dist_body = enemy
			last_min_dist = min_dist
	#ready_for_shader.emit(min_dist_body.position)
	return min_dist_body
	

func _chain_enemies(starting_body, starting_position) ->  int:
	print("chaining")
	if starting_body != null:
		already_hit_dict.set(starting_body, 0)
	var chained_body = calculate_closest_to(starting_body, starting_position)
	var last_chained_body
	if chained_body == null:
		print("failed")
		return 0
	chained_body.hit(chain_damage)
	last_chained_body = chained_body
	bounces = bounces - 1
	"""
	while bounces > 0:
		chained_body = calculate_closest_to(starting_body, starting_position)
		if chained_body == null:
			return 0
		chained_body.hit(chain_damage)
		last_chained_body = chained_body
		bounces = bounces - 1
	"""
	return 1
	#do calculate closest
	#get the body out of there
	#hit it and visualize it
	#put it back into the calculate closest
	#repeat this until out of bounces or out of bodies
	visible = true
