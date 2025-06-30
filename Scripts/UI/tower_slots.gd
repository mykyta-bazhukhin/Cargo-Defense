extends Control


var tower_selection_array: Array

func _ready():
	await get_node("../../").ready
	for i in range(tower_selection_array.size()):
		if (tower_selection_array[i] == null):
			continue
		var tower_temp = tower_selection_array[i].instantiate()
		get_node("%TowerImage" + str(i)).texture = tower_temp.get_node("Sprite2D").texture
		get_node("%TowerCost" + str(i)).text = str(tower_temp.cost)
		tower_temp.free()
		
	
func _process(_delta: float) -> void:
	$TowerPanel0/ProgressBar.value = $TowerPanel0/TowerCooldown.time_left
	$TowerPanel1/ProgressBar.value = $TowerPanel1/TowerCooldown.time_left
	$TowerPanel2/ProgressBar.value = $TowerPanel2/TowerCooldown.time_left


func _on_towers_tower_placed(tower_num: int, cooldown_time: float) -> void:
	get_child(tower_num).get_child(1).max_value = cooldown_time
	get_child(tower_num).get_child(2).wait_time = cooldown_time
	get_child(tower_num).get_child(2).start()
