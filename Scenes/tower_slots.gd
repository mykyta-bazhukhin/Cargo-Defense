extends Control
var TowerSampleScene = preload("res://Scenes/tower_sample.tscn")
var TowerSniperScene = preload("res://Scenes/tower_sniper.tscn")
var FreezeTowerScene = preload("res://Scenes/freeze_tower.tscn")
var BasicTowerScene = preload("res://Scenes/basic_tower.tscn")

var tower_selection: Array = [BasicTowerScene,TowerSniperScene,FreezeTowerScene]

func _ready():
	for i in range(tower_selection.size()):
		if (tower_selection[i] == null):
			continue
		var tower_temp = tower_selection[i].instantiate()
		get_node("%TowerImage" + str(i + 1)).texture = tower_temp.get_node("Sprite2D").texture
		get_node("%TowerCost" + str(i + 1)).text = str(tower_temp.cost)
		tower_temp.free()
		
	
	
