extends Node2D

var LaserScene = preload("res://Scenes/laser.tscn")
var RocketScene = preload("res://Scenes/rocket.tscn")

func _on_space_plane_shoot_primary(pos: Vector2):
	var laser = LaserScene.instantiate()
	laser.position = pos
	add_child(laser)


func _on_space_plane_shoot_secondary(pos: Vector2):
	var rocket = RocketScene.instantiate()
	rocket.position = pos
	add_child(rocket)
