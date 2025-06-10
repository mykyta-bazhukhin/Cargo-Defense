extends Control


var tower_selection_array: Array

func _ready():
	await get_node("../../").ready
	for i in range(tower_selection_array.size()):
		if (tower_selection_array[i] == null):
			continue
		var tower_temp = tower_selection_array[i].instantiate()
		get_node("%TowerImage" + str(i + 1)).texture = tower_temp.get_node("Sprite2D").texture
		get_node("%TowerCost" + str(i + 1)).text = str(tower_temp.cost)
		tower_temp.free()
		
	
	
