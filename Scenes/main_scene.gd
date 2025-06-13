extends Node2D



var tower_selection_array: Array = Global.selected_towers
#
#func _on_carrier_enemy_enemy_dead(pos, val):
#	#print("recieving")
#	var scrap = scrap_scene.instantiate()
#	scrap.value = val
#	scrap.position = pos
#	$Scraps.add_child(scrap)
#	


func _ready():
	$%Towers.tower_selection_array = tower_selection_array
	$%TowerSlotsVBox.tower_selection_array = tower_selection_array
	#$%Towers.tower_points_array = $TowerPoints.get_children()


func _on_enemies_create_scrap(pos: Vector2, val: int) -> void:
	pass # Replace with function body.


func _on_towers_get_total_scrap() -> void:
	$%Towers.total_scrap = $Scraps.total_scrap
