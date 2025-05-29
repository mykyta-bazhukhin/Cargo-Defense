extends Node2D


#
#func _on_carrier_enemy_enemy_dead(pos, val):
#	#print("recieving")
#	var scrap = scrap_scene.instantiate()
#	scrap.value = val
#	scrap.position = pos
#	$Scraps.add_child(scrap)
#	





func _on_enemies_create_scrap(pos: Vector2, val: int) -> void:
	pass # Replace with function body.


func _on_towers_get_total_scrap() -> void:
	$%Towers.total_scrap = $Scraps.total_scrap
