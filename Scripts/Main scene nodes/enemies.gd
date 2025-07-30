extends Node2D

var EnemySampleScene = preload("res://Scenes/Enemies/enemy_placeholder.tscn")
var EnemyCarrierScene = preload("res://Scenes/Enemies/enemy_carrier.tscn")
var BasicMinerScene = preload("res://Scenes/Enemies/basic_miner.tscn")


signal create_scrap(pos: Vector2, val: int)

var enemy_list: Array = [EnemySampleScene, EnemyCarrierScene, BasicMinerScene]

func _on_enemy_dead(pos: Vector2, val: int):
	create_scrap.emit(pos, val)
	
func spawn_enemy_random():
	var random_number = randi_range(0, len(enemy_list)-1)
	var enemy = enemy_list[random_number].instantiate()
	add_child(enemy)
	enemy.connect("enemy_dead", _on_enemy_dead)
	enemy.position = Vector2(randf_range(192, 1168), -200)
	enemy.speed = 100

func _on_spawn_enemy_timer_timeout() -> void:
	spawn_enemy_random()
