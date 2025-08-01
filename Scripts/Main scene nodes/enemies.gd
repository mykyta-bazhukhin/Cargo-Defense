extends Node2D

var EnemySampleScene = preload("res://Scenes/Enemies/enemy_placeholder.tscn")
var EnemyCarrierScene = preload("res://Scenes/Enemies/enemy_carrier.tscn")
var BasicMinerScene = preload("res://Scenes/Enemies/basic_miner.tscn")


signal create_scrap(pos: Vector2, val: int)

var enemy_list: Array = [EnemySampleScene, EnemyCarrierScene, BasicMinerScene]
var enemy_spawns_x: Array = [256, 384, 512, 640, 768, 896, 1024]

func _on_enemy_dead(pos: Vector2, val: int):
	create_scrap.emit(pos, val)
	
func spawn_enemy_random():
	var random_enemy_number = randi_range(0, len(enemy_list)-1)
	var spawn_x_pos = enemy_spawns_x[randi_range(0, len(enemy_spawns_x)-1)] + randi_range(-10, 10)
	var spawn_y_pos = randf_range(-100, -200)
	var enemy = enemy_list[random_enemy_number].instantiate()
	add_child(enemy)
	enemy.connect("enemy_dead", _on_enemy_dead)
	enemy.position = Vector2(spawn_x_pos, spawn_y_pos)
	enemy.speed = 100

func _on_spawn_enemy_timer_timeout() -> void:
	spawn_enemy_random()
