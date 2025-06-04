extends Node2D

var TowerSampleScene = preload("res://Scenes/tower_sample.tscn")

var tower_selection_array: Array = [TowerSampleScene,null,null]
var tower_costs: Array = [0,0,0]
var tower_points_array: Array #can also be handled by main

signal scrap_used(value)

func _ready() -> void:
	tower_points_array = get_node("../TowerPoints").get_children()
	var i = 0
	for tower_scene in tower_selection_array:
		if (tower_scene != null):
			var tower = tower_scene.instantiate() #tower needs to instantiate to be able to acess cost for if states
			tower_costs[i] = tower.cost
			tower.free()
		i = i + 1 

func _process(delta: float) -> void:
	#NOTE: tower selection code
	if (Input.is_action_just_pressed("Place tower 1") and tower_selection_array[0] != null and tower_costs[0] <= get_node("../Scraps").total_scrap):
		#print("sapwn")
		FIND_POINT_spawn_tower_approach_point(0)
	if (Input.is_action_just_pressed("Place tower 2") and tower_selection_array[1] != null and tower_costs[1] <= get_node("../Scraps").total_scrap):
		FIND_POINT_spawn_tower_approach_point(1)
	if (Input.is_action_just_pressed("Place tower 3") and tower_selection_array[2] != null and tower_costs[2] <= get_node("../Scraps").total_scrap):
		FIND_POINT_spawn_tower_approach_point(2)

#NOTE: tower placing code
func FIND_POINT_spawn_tower_approach_point(tower_num: int):
	'''this is a super function, a big function that has been split up into three parts
	with capital letter denoting what happens in the function'''
	var final_min_point_position: Vector2
	# first finding the closest row of points to the turret
	var min_dist_point = tower_points_array[0]
	var min_dist = tower_points_array[0].position.distance_to(get_node("../SpacePlane").position)
	var cur_dist = 0
	for i in tower_points_array.size():
		#if (tower_points_array[i].is_in_group("Not Occupied")):
		cur_dist = tower_points_array[i].position.distance_to(get_node("../SpacePlane").position)
		#print(str(pythagrean_therom(tower_points_array[i], tower)) + " " + str(i))
		if (cur_dist <= min_dist):
			min_dist = cur_dist
			min_dist_point = tower_points_array[i]
			#print("position of new min: " + str(i))
	if (min_dist_point.is_in_group("Not Occupied")):
		final_min_point_position = Vector2(min_dist_point.position.x, min_dist_point.position.y)
		min_dist_point.remove_from_group("Not Occupied")
		find_point_SPAWN_TOWER_approach_point(tower_num, final_min_point_position)
	else:
		print("position occupied")
func find_point_SPAWN_TOWER_approach_point(tower_num: int, min_pos):
	var tower = tower_selection_array[tower_num].instantiate()
	tower.position = get_node("../SpacePlane").position
	print(tower.position)
	tower.connect("shoot_turret", Callable(get_node("../Projectiles"), "_on_shoot_turret"))
	add_child(tower)
	scrap_used.emit(tower_costs[tower_num])
	find_point_spawn_tower_APPROACH_POINT(min_pos, tower)
func find_point_spawn_tower_APPROACH_POINT(min_pos, tower):
	var tween = get_tree().create_tween()
	tween.tween_property(tower, "position", min_pos, 0.5).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	await tween.finished
	tower.get_node("PlatformSprite").visible = true
