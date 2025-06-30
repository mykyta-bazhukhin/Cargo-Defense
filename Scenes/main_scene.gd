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


func _on_towers_get_total_scrap() -> void:
	$%Towers.total_scrap = $Scraps.total_scrap
