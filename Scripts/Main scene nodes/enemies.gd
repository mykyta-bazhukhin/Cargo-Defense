extends Node2D

var EnemySampleScene = preload("res://Scenes/Enemies/enemy_placeholder.tscn")
var EnemyCarrierScene = preload("res://Scenes/Enemies/enemy_carrier.tscn")
var BasicMinerScene = preload("res://Scenes/Enemies/basic_miner.tscn")


signal create_scrap(pos: Vector2, val: int)

var wave_amount = 0
var wave_num = 0
var cur_wave_max_health = 0
var cur_wave_enemies: Array
var enemy_list: Array = [EnemySampleScene, EnemyCarrierScene, BasicMinerScene]
var enemy_spawns_x: Array = [256, 384, 512, 640, 768, 896, 1024]

func _ready() -> void:
	wave_amount = randi_range(1,5)*10

func _process(delta: float) -> void:
	var next_wave_time_to_wait = 3
	var total_wave_health = 0
	for enemy in cur_wave_enemies:
		if enemy != null:
			total_wave_health += enemy.health
	if (total_wave_health < cur_wave_max_health/2) and $SpawnEnemyTimer.time_left > next_wave_time_to_wait:
		$SpawnEnemyTimer.wait_time = next_wave_time_to_wait
		$SpawnEnemyTimer.start()

func spawn_next_wave():
	cur_wave_max_health = 0
	cur_wave_enemies = []
	for i in range(0, 5+wave_num):
		#NOTE: choosing what enemy to send prob goes here
		var random_enemy_num = randi_range(0, len(enemy_list)-1)
		spawn_enemy(random_enemy_num)
	$SpawnEnemyTimer.wait_time = 15
	$SpawnEnemyTimer.start()
	wave_num += 1
	
func spawn_enemy(random_enemy_num):
	var enemy = enemy_list[random_enemy_num].instantiate()
	var spawn_x_pos = enemy_spawns_x[randi_range(0, len(enemy_spawns_x)-1)] + randi_range(-10, 10)
	var spawn_y_pos = randf_range(-100, -200)
	add_child(enemy)
	enemy.connect("enemy_dead", _on_enemy_dead)
	enemy.position = Vector2(spawn_x_pos, spawn_y_pos)
	cur_wave_enemies.append(enemy)
	cur_wave_max_health += enemy.health

func _on_enemy_dead(pos: Vector2, val: int):
	create_scrap.emit(pos, val)

func _on_spawn_enemy_timer_timeout() -> void:
	spawn_next_wave()
