extends Node2D

var PrimaryWeaponScene = Global.selected_weapons[0]
var SecondaryWeaponScene = Global.selected_weapons[1]
#var LaserScene = preload("res://Scenes/Plane/Weapons/laser.tscn")
#var RocketScene = preload("res://Scenes/Plane/Weapons/rocket.tscn")
var TowerSampleProjectileScene = preload("res://Scenes/Towers/Projectiles/tower_sample_projectile.tscn")
var FreezeBulletScene = preload("res://Scenes/Towers/Projectiles/freeze_bullet.tscn")
var TaserBulletScene = preload("res://Scenes/Plane/Weapons/laser_taser.tscn")
var ChainLightningScene = preload("res://Scenes/Plane/Weapons/chain_lightning.tscn")
#var CannonBallScene = preload("res://Scenes/Plane/Weapons/cannon_ball.tscn")

var projectile_dict = {"Freeze bullet" : FreezeBulletScene, "Bullet" : TowerSampleProjectileScene, "Taser bullet" : TaserBulletScene}


func _on_space_plane_shoot_primary(pos: Vector2, _cooldown_time: float):
	var primary_weapon = PrimaryWeaponScene.instantiate()
	primary_weapon.position = pos
	add_child(primary_weapon)


func _on_space_plane_shoot_secondary(pos: Vector2, _cooldown_time: float):
	var secondary_weapon = SecondaryWeaponScene.instantiate()
	secondary_weapon.position = pos
	add_child(secondary_weapon)
	
func _on_shoot_turret(pos):
	var ball = TowerSampleProjectileScene.instantiate()
	ball.position = pos
	add_child(ball)
	
func _on_shoot_projectile(pos, scene_name):
	var scene = projectile_dict.get(scene_name)
	var projectile = scene.instantiate()
	projectile.position = pos
	add_child(projectile)

func _create_chain_lightning(pos, end_pos):
	var lightning = ChainLightningScene.instantiate()
	lightning.position = pos
	lightning.start_pos = pos
	lightning.end_pos = end_pos
	call_deferred("add_child", lightning)
