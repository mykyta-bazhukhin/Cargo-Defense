extends Node2D

var LaserScene = preload("res://Scenes/laser.tscn")
var RocketScene = preload("res://Scenes/rocket.tscn")
var TowerSampleProjectileScene = preload("res://Scenes/tower_sample_projectile.tscn")
var FreezeBulletScene = preload("res://Scenes/freeze_bullet.tscn")

var projectile_dict = {"Freeze bullet" : FreezeBulletScene, "Bullet" : TowerSampleProjectileScene}


func _on_space_plane_shoot_primary(pos: Vector2):
	var laser = LaserScene.instantiate()
	laser.position = pos
	add_child(laser)


func _on_space_plane_shoot_secondary(pos: Vector2):
	var rocket = RocketScene.instantiate()
	rocket.position = pos
	add_child(rocket)
	
func _on_shoot_turret(pos):
	var ball = TowerSampleProjectileScene.instantiate()
	ball.position = pos
	add_child(ball)
	
func _on_shoot_projectile(pos, scene_name):
	var scene = projectile_dict.get(scene_name)
	var projectile = scene.instantiate()
	projectile.position = pos
	add_child(projectile)
