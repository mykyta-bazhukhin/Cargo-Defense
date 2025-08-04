extends Node2D



var tower_selection_array: Array = Global.selected_towers
#
#func _on_carrier_enemy_enemy_dead(pos, val):
#	#print("recieving")
#	var scrap = scrap_scene.instantiate()
#	scrap.value = val
#	scrap.position = pos
#	$Scraps.add_child(scrap)

func _process(_delta: float) -> void:
	pass

func _ready():
	#NOTE: setting up UI code
	$%Towers.tower_selection_array = tower_selection_array
	$%TowerSlotsVBox.tower_selection_array = tower_selection_array
	
	$%WeaponCooldownHBox.plane_primary_timer = $SpacePlane/PrimaryTimer
	$%WeaponCooldownHBox.plane_secondary_timer = $SpacePlane/SecondaryTimer
	
	#NOTE: Setting up other things from global WARNING: I need to put other global set up stuff in here
	var primary_weapon = Global.selected_weapons[0].instantiate()
	var secondary_weapon = Global.selected_weapons[1].instantiate()

	%PrimaryCooldownBar.texture_under = load(primary_weapon.icon)
	%SecondaryCooldownBar.texture_under = load(secondary_weapon.icon)
	
	$SpacePlane/PrimaryTimer.wait_time = primary_weapon.cooldown
	$SpacePlane/PrimaryTimer.start()
	$SpacePlane/SecondaryTimer.wait_time = secondary_weapon.cooldown
	$SpacePlane/SecondaryTimer.start()
	
	primary_weapon.free()
	secondary_weapon.free()

func _on_towers_get_total_scrap() -> void:
	$%Towers.total_scrap = $Scraps.total_scrap

func _get_enemies() -> Array:
	var enemy_array: Array
	for child in $Enemies.get_children():
		if child.get_class() == "CharacterBody2D":
			enemy_array.append(child)
	return enemy_array
