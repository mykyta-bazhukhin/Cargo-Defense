extends Control

var TowerSampleScene = preload("res://Scenes/tower_sample.tscn")
var TowerSniperScene = preload("res://Scenes/tower_sniper.tscn")
var FreezeTowerScene = preload("res://Scenes/freeze_tower.tscn")
var BasicTowerScene = preload("res://Scenes/basic_tower.tscn")
var RepeaterTowerScene = preload("res://Scenes/repeater_tower.tscn")
var FlameTowerScene = preload("res://Scenes/flame_tower.tscn")

var all_towers: Array = [BasicTowerScene, FreezeTowerScene, BasicTowerScene, RepeaterTowerScene,
FlameTowerScene]
var selected_towers: Array = [null,null,null]
var cur_selected_num: int

func _ready() -> void:
	cur_selected_num = 0
	var tower_rows = $%AvailableTowersVBox.get_children()
	var tower_num = 0
	for row in tower_rows:
		for tower_panel in row.get_children():
			if (tower_num >= all_towers.size()):
				break
			var tower_temp = all_towers[tower_num].instantiate()
			tower_panel.get_node("VBoxContainer/TowerImage1").texture = tower_temp.get_node("Sprite2D").texture
			tower_panel.get_node("VBoxContainer/PanelContainer/HBoxContainer/TowerCost1").text = str(tower_temp.cost)
			tower_temp.free()
			tower_num = tower_num + 1
			

	#for i in range(all_towers.size()):
	#	if (all_towers[i] == null):
			continue
	#	var tower_temp = all_towers[i].instantiate()
	#	get_node("%TowerImage" + str(i + 1)).texture = tower_temp.get_node("Sprite2D").texture
	#	get_node("%TowerCost" + str(i + 1)).text = str(tower_temp.cost)
	#	tower_temp.free()


func _on_button_pressed() -> void:
	print("pressed")
