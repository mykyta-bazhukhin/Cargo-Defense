extends Node2D

var tower1_cost

var laser_scene = preload("res://Scenes/laser.tscn")
var rocket_scene = preload("res://Scenes/rocket.tscn")
var tower_sample_scene = preload("res://Scenes/tower_sample.tscn")
var scrap_scene = preload("res://Scenes/scrap.tscn")
var enemy_sample_scene = preload("res://Scenes/placeholder_enemy.tscn")
var carrier_enemy = preload("res://Scenes/carrier_enemy.tscn")
var tower_sample_projectile_scene = preload("res://Scenes/tower_sample_projectile.tscn")

var tower_selection_array: Array = [null,null,null]
var enemy_list: Array = [enemy_sample_scene, carrier_enemy]
var tower_points_array: Array

func _ready():
	for i in $Tower_points.get_child_count():
		tower_points_array.append($Tower_points.get_child(i).get_children()) #appends each row's children to one array
	tower_selection_array[0] = tower_sample_scene
	var tower1 = tower_selection_array[0].instantiate() #tower needs to instantiate to be able to acess cost for if states
	# could be solved by giving each tower its unique cost in global code
	tower1_cost = tower1.cost
func _on_shoot_turret(pos):
	var ball = tower_sample_projectile_scene.instantiate()
	ball.position = pos
	$Projectiles.add_child(ball)
func _select_tower(number: int):
	var tower = tower_selection_array[number].instantiate()
	tower.position = $Space_plane.position
	tower.connect("shoot_turret", _on_shoot_turret)
	$Towers.add_child(tower)
	find_closest_tower_point_and_approach(tower)
	Global.scrap -= tower.cost
func pythagrean_therom(var1, var2): #returns the result of a pathagreon therom(distance) between 2 variables
	return sqrt(pow(var1.position.x-var2.position.x, 2) + pow(var1.position.y-var2.position.x, 2))

func _process(_delta):
	
	
	
	#tower selection code
	if (Input.is_action_just_pressed("Place tower 1") and tower_selection_array[0] != null and tower1_cost <= Global.scrap):
		print("sapwn")
		_select_tower(0)
	if (Input.is_action_just_pressed("Place tower 2") and tower_selection_array[1] != null and tower_selection_array[1].cost <= Global.scrap):
		var tower = tower_selection_array[1].instantiate() #fix these two to use select tower func
		tower.position = $Space_plane.position
		tower.connect("shoot_turret", _on_shoot_turret)
		$Towers.add_child(tower)
	if (Input.is_action_just_pressed("Place tower 3") and tower_selection_array[2] != null and tower_selection_array[2].cost <= Global.scrap):
		var tower = tower_selection_array[2].instantiate()
		tower.position = $Space_plane.position
		tower.connect("shoot_turret", _on_shoot_turret)
		$Towers.add_child(tower)
		
	#debug code
	if (Input.is_action_just_pressed("give_scrap")):
		Global.scrap += 1

func find_closest_tower_point_and_approach(tower):
	var final_min_point_position: Vector2
	# first finding the closest row of points to the turret
	var min_dist_point = tower_points_array[0]
	var min_dist = pythagrean_therom(tower_points_array[0], tower)
	var cur_dist = 0
	for i in tower_points_array.size():
		if (tower_points_array[i].is_in_group("Not Occupied")):
			cur_dist = pythagrean_therom(tower_points_array[i], tower)
			if (cur_dist <= min_dist):
				min_dist = cur_dist
				min_dist_point = tower_points_array[i]
		else:
			print("position occupied")
	final_min_point_position = Vector2(min_dist_point.position.x, min_dist_point.position.y)
	min_dist_point.remove_from_group("Not Occupied")
	var tween = get_tree().create_tween()
	tween.tween_property(tower, "position", final_min_point_position, 0.5).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
	var min_dist_row = tower_points_array[0]
	var min_dist_y = abs(tower_points_array[0].position.y - tower.position.y)
	var cur_dist_y = 0
	for i in tower_points_array.size():
		cur_dist_y = abs(tower_points_array[i].position.y - tower.position.y)
		if (cur_dist_y <= min_dist_y):
			min_dist_y = cur_dist_y
			min_dist_row = tower_points_array[i]
	#after that use the found row to find the closest point
	var row_num_points_array = min_dist_row.get_children()
	var min_dist_colum = row_num_points_array[0]
	var min_dist_x = abs(tower_points_array[0].position.x - tower.position.x)
	var cur_dist_x = 0
	for i in row_num_points_array.size():
		if (row_num_points_array[i].is_in_group("Not Occupied")):
			cur_dist_x = abs(row_num_points_array[i].position.x - tower.position.x)
			if (cur_dist_x <= min_dist_x):
				min_dist_x = cur_dist_x
				min_dist_colum = row_num_points_array[i]
		else:
			print("position occupied")



func spawn_enemy_random():
	var random_number = randi_range(0, len(enemy_list)-1)
	var enemy = enemy_list[random_number].instantiate()
	$Enemies.add_child(enemy)
	enemy.connect("enemy_dead", _on_enemy_dead)
	enemy.position = Vector2(randf_range(192, 1168), -200)
	enemy.speed = 100
	
func _on_enemy_dead(pos, val):
	
	var scrap = scrap_scene.instantiate()
	scrap.value = val
	scrap.position = pos
	$Scraps.add_child(scrap)

func _on_space_plane_shoot_primary(pos):
	var laser = laser_scene.instantiate()
	laser.position = pos
	$Projectiles.add_child(laser)


func _on_space_plane_shoot_secondary(pos):
	var rocket = rocket_scene.instantiate()
	rocket.position = pos
	$Projectiles.add_child(rocket)


func _on_carrier_enemy_enemy_dead(pos, val):
	print("recieving")
	var scrap = scrap_scene.instantiate()
	scrap.value = val
	scrap.position = pos
	$Scraps.add_child(scrap)
	


func _on_test_timer_timeout():
	spawn_enemy_random()
