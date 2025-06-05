extends Control
var TowerSampleScene = preload("res://Scenes/tower_sample.tscn")
var TowerSniper = preload("res://Scenes/tower_sniper.tscn")

var tower_selection: Array = [TowerSampleScene,TowerSniper,null]

func _ready():
	for i in range(tower_selection.size()):
		if (tower_selection[i] == null):
			continue
		var tower_temp = tower_selection[i].instantiate()
		get_node("%TowerImage" + str(i + 1)).texture = tower_temp.get_node("Sprite2D").texture
		get_node("%TowerCost" + str(i + 1)).text = str(tower_temp.cost)
		tower_temp.free()
		
	
	
