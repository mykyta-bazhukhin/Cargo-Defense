extends Control

var PanelScene = preload("res://Scenes/tower_panel.tscn")
var TowerSampleScene = preload("res://Scenes/tower_sample.tscn")
var TowerSniperScene = preload("res://Scenes/tower_sniper.tscn")
var FreezeTowerScene = preload("res://Scenes/freeze_tower.tscn")
var BasicTowerScene = preload("res://Scenes/basic_tower.tscn")
var RepeaterTowerScene = preload("res://Scenes/repeater_tower.tscn")
var FlameTowerScene = preload("res://Scenes/flame_tower.tscn")

var all_towers: Array = [null, BasicTowerScene, FreezeTowerScene, BasicTowerScene, RepeaterTowerScene,
FlameTowerScene]
var selected_towers: Array = [null,null,null]
var selected_panels: Array = [null,null,null]
var cur_available_slot: int

func _ready() -> void:
	cur_available_slot = 0
	var tower_rows = $%AvailableTowersVBox.get_children()
	var tower_num = 0
	for row in tower_rows:
		for tower_panel in row.get_children():
			if (tower_num >= all_towers.size()):
				break
			if (all_towers[tower_num] == null):
				tower_num = tower_num + 1
				continue
			var tower_temp = all_towers[tower_num].instantiate()
			#tower_panel.add_to_group("not selected")
			tower_panel.get_child(1).connect("pressed", _on_button_pressed.bind(tower_num, tower_panel))
			tower_panel.get_node("VBoxContainer/TowerImage1").texture = tower_temp.get_node("Sprite2D").texture
			tower_panel.get_node("VBoxContainer/PanelContainer/HBoxContainer/TowerCost1").text = str(tower_temp.cost)
			tower_temp.free()
			tower_num = tower_num + 1

func _create_a_selected_panel(tower_panel):
	$%SelectedTowersList.remove_child($%SelectedTowersList.get_child(cur_available_slot))
	var selected_tower_panel = tower_panel.duplicate()
	#selected_tower_panel.get_child(1).connect("pressed", )
	#print(selected_tower_panel.is_connected("pressed", _on_button_pressed))
	$%SelectedTowersList.add_child(selected_tower_panel)
	$%SelectedTowersList.move_child(selected_tower_panel, cur_available_slot)

func _on_button_pressed(slot_num: int, tower_panel) -> void:
	#var pending_all_tower_change
	if (cur_available_slot < selected_towers.size() and selected_towers[cur_available_slot] == null 
	and all_towers[slot_num] != null):
		selected_towers[cur_available_slot] = all_towers[slot_num]
		all_towers[slot_num] = null
		_create_a_selected_panel(tower_panel)
		tower_panel.modulate = Color(0.5,0.5,0.5)
		cur_available_slot = cur_available_slot + 1
	#if (all_towers[slot_num] == null):
	#	pending_all_tower_change = selected_towers[cur_available_slot]
	#	selected_towers[cur_available_slot] = null
	#	#tower_panel.add_to_group("not selected")
	#	cur_available_slot = cur_available_slot - 1
	#all_towers[slot_num] = pending_all_tower_change
