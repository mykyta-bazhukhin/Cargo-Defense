extends Node2D

var tower1_cost

var TowerSampleScene = preload("res://Scenes/tower_sample.tscn")
var TowerSampleProjectileScene = preload("res://Scenes/tower_sample_projectile.tscn")

var tower_selection_array: Array = [null,null,null]
var tower_points_array: Array

func _ready():
	tower_points_array = $TowerPoints.get_children()
	#for i in $Tower_points.get_child_count():
	#	tower_points_array.append($Tower_points.get_child(i).get_children()) #appends each row's children to one array
	tower_selection_array[0] = TowerSampleScene
	var tower1 = tower_selection_array[0].instantiate() #tower needs to instantiate to be able to acess cost for if states
	# could be solved by giving each tower its unique cost in global code
	tower1_cost = tower1.cost
	tower1.free()
func _on_shoot_turret(pos):
	var ball = TowerSampleProjectileScene.instantiate()
	ball.position = pos
	$Projectiles.add_child(ball)

#func pythagrean_therom(var1, var2): #returns the result of a pathagreon therom(distance) between 2 variables
	#return sqrt(pow(var1.position.x-var2.position.x, 2) + pow(var1.position.y-var2.position.y, 2))

func _process(_delta):
	var plane_speed = $SpacePlane.speed
	#NOTE: tower selection code
	if (Input.is_action_just_pressed("Place tower 1") and tower_selection_array[0] != null and tower1_cost <= Global.scrap):
		#print("sapwn")
		FIND_POINT_spawn_tower_approach_point(0)
	if (Input.is_action_just_pressed("Place tower 2") and tower_selection_array[1] != null and tower_selection_array[1].cost <= Global.scrap):
		var tower = tower_selection_array[1].instantiate() #fix these two to use select tower func
		tower.position = $SpacePlane.position
		tower.connect("shoot_turret", _on_shoot_turret)
		$Towers.add_child(tower)
	if (Input.is_action_just_pressed("Place tower 3") and tower_selection_array[2] != null and tower_selection_array[2].cost <= Global.scrap):
		var tower = tower_selection_array[2].instantiate()
		tower.position = $SpacePlane.position
		tower.connect("shoot_turret", _on_shoot_turret)
		$Towers.add_child(tower)
		
	#NOTE: debug code
	if (Input.is_action_just_pressed("give_scrap")):
		Global.scrap += 1
#NOTE: tower placing code
func FIND_POINT_spawn_tower_approach_point(num: int):
	'''this is a super function, a big function that has been split up into three parts
	with capital letter denoting what happens in the function'''
	var final_min_point_position: Vector2
	# first finding the closest row of points to the turret
	var min_dist_point = tower_points_array[0]
	var min_dist = tower_points_array[0].position.distance_to($SpacePlane.position)
	var cur_dist = 0
	for i in tower_points_array.size():
		#if (tower_points_array[i].is_in_group("Not Occupied")):
		cur_dist = tower_points_array[i].position.distance_to($SpacePlane.position)
		#print(str(pythagrean_therom(tower_points_array[i], tower)) + " " + str(i))
		if (cur_dist <= min_dist):
			min_dist = cur_dist
			min_dist_point = tower_points_array[i]
			#print("position of new min: " + str(i))
	if (min_dist_point.is_in_group("Not Occupied")):
		final_min_point_position = Vector2(min_dist_point.position.x, min_dist_point.position.y)
		min_dist_point.remove_from_group("Not Occupied")
		find_point_SPAWN_TOWER_approach_point(num, final_min_point_position)
	else:
		print("position occupied")
func find_point_SPAWN_TOWER_approach_point(num: int, min_pos):
	var tower = tower_selection_array[num].instantiate()
	tower.position = $SpacePlane.position
	print(tower.position)
	tower.connect("shoot_turret", _on_shoot_turret)
	$Towers.add_child(tower)
	Global.scrap -= tower.cost
	find_point_spawn_tower_APPROACH_POINT(min_pos, tower)
func find_point_spawn_tower_APPROACH_POINT(min_pos, tower):
	var tween = get_tree().create_tween()
	tween.tween_property(tower, "position", min_pos, 0.5).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	await tween.finished
	tower.get_node("PlatformSprite").visible = true
	


#
#func _on_carrier_enemy_enemy_dead(pos, val):
#	#print("recieving")
#	var scrap = scrap_scene.instantiate()
#	scrap.value = val
#	scrap.position = pos
#	$Scraps.add_child(scrap)
#	





func _on_enemies_create_scrap(pos: Vector2, val: int) -> void:
	pass # Replace with function body.
