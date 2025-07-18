extends Area2D

var bounces = 1
var chain_damage = 3
var chain_range
var tiling_amount = 20
var size = 64
var distance
var seed

var tot_enemies: Array
var enemies_in_range: Array
var already_hit_dict: Dictionary
#signal ready_for_shader(end_pos, start_pos)

func _ready() -> void:
	tot_enemies = get_parent().get_parent()._get_enemies()
	chain_range = 500 #$LightningRangeVisual.shape.radius
	visible = false
	#$ChainLightning.material.shader = load("res://Shaders/chain_lightning_shader.gdshader")
	$ChainLightningSprite.material.set_shader_parameter("seed", randi() % 10000)
	
	#ready_for_shader.emit(end_pos, start_pos)


func find_enemies_in_range_of(body, body_position):
	var body_to_enemy_distance
	var enemy_position
	for enemy in tot_enemies:
		if (enemy != null and enemy not in already_hit_dict and enemy.position.distance_to(body_position) <= chain_range):
			#enemy_position = enemy.position
			#body_to_enemy_distance = enemy.position.distance_to(body_position)
			enemies_in_range.append(enemy)
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
	
	if starting_body != null:
		already_hit_dict.set(starting_body, 0)
	var chained_body = calculate_closest_to(starting_body, starting_position)
	#var last_chained_body
	if chained_body == null:
		return 0
	position = starting_position
	distance = starting_position.distance_to(chained_body.position)
	look_at(chained_body.position)
	tiling_amount = distance/size
	$ChainLightningSprite.material.set_shader_parameter("tiling_amount", tiling_amount)
	scale = Vector2(tiling_amount,1)
	visible = true
	chained_body.hit(chain_damage)
	#last_chained_body = chained_body
	bounces = bounces - 1
	
	$TimerTimeout.start()
	return 1


func _on_timer_timeout_timeout() -> void:
	queue_free()
