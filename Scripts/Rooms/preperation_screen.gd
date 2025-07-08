extends Control

var PanelScene = preload("res://Scenes/UI/tower_panel.tscn")
var TowerSampleScene = preload("res://Scenes/Towers/tower_sample.tscn")
var TowerSniperScene = preload("res://Scenes/Towers/tower_sniper.tscn")
var FreezeTowerScene = preload("res://Scenes/Towers/freeze_tower.tscn")
var BasicTowerScene = preload("res://Scenes/Towers/basic_tower.tscn")
var RepeaterTowerScene = preload("res://Scenes/Towers/repeater_tower.tscn")
var FlameTowerScene = preload("res://Scenes/Towers/flame_tower.tscn")

var all_towers: Array = [null, BasicTowerScene, FreezeTowerScene, BasicTowerScene, RepeaterTowerScene,
FlameTowerScene]
var selected_towers: Array = [null,null,null]
var cur_available_slot: int
var empty_panel: Panel
var distance_to_slot

func _ready() -> void:
	empty_panel = $%SelectedTowersList.get_child(0)
	cur_available_slot = 0
	$StartButton.disabled = true
	distance_to_slot = %SelectedTowersList.get_theme_constant("separation", "HBoxContainer") + $TowerSelectionPanel/SelectedTowersPanel/SelectedTowersList/Panel0.custom_minimum_size.x

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
			tower_panel.get_child(1).connect("pressed", _on_avilable_tower_button_pressed.bind(tower_num, tower_panel))
			tower_panel.get_node("VBoxContainer/TowerImage1").texture = tower_temp.get_node("Sprite2D").texture
			tower_panel.get_node("VBoxContainer/PanelContainer/HBoxContainer/TowerCost1").text = str(tower_temp.cost)
			tower_temp.free()
			tower_num = tower_num + 1


func tween_from_another_panel(selected_panel, another_panel):
	var og_selected_position = Vector2(selected_panel.get_index()*distance_to_slot, 0)
	var tween = get_tree().create_tween()
	tween.tween_property(selected_panel, "global_position", another_panel.global_position, 0.01)
	tween.tween_property(selected_panel, "position", og_selected_position, 0.2).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	await tween.finished
func _sort_nulls(array: Array):
	for i in range(array.size()-1):
		if (array[i] == null and array[i+1] != null):
			var temp = array[i]
			array[i] = array[i+1]
			array[i+1] = temp
	return array
func _create_a_selected_panel(slot_num, tower_panel):
	$%SelectedTowersList.remove_child($%SelectedTowersList.get_child(cur_available_slot))
	var selected_tower_panel = tower_panel.duplicate()
	selected_tower_panel.get_child(1).connect("pressed", _on_selected_tower_button_pressed.bind(slot_num, tower_panel, selected_tower_panel))
	$%SelectedTowersList.add_child(selected_tower_panel)
	$%SelectedTowersList.move_child(selected_tower_panel, cur_available_slot)
	return selected_tower_panel

func _on_avilable_tower_button_pressed(slot_num: int, tower_panel) -> void:
	if (cur_available_slot < selected_towers.size() and selected_towers[cur_available_slot] == null 
	and all_towers[slot_num] != null):
		selected_towers[cur_available_slot] = all_towers[slot_num]
		all_towers[slot_num] = null
		var selected_tower_panel = _create_a_selected_panel(slot_num, tower_panel)
		tween_from_another_panel(selected_tower_panel, tower_panel)
		tower_panel.modulate = Color(0.5,0.5,0.5)
		cur_available_slot = cur_available_slot + 1
	if (cur_available_slot == selected_towers.size()):
		$StartButton.disabled = false
func _on_selected_tower_button_pressed(og_slot_num, og_tower_panel, selected_tower_panel) -> void:
	var selected_slot_num = selected_tower_panel.get_index()
	all_towers[og_slot_num] = selected_towers[selected_slot_num]
	og_tower_panel.modulate = Color(1,1,1)
	selected_towers[selected_slot_num] = null
	$%SelectedTowersList.get_child(selected_slot_num).queue_free()
	$%SelectedTowersList.add_child(empty_panel.duplicate())
	selected_towers = _sort_nulls(selected_towers)
	cur_available_slot = cur_available_slot - 1
	$StartButton.disabled = true
func _on_start_button_pressed() -> void:
	Global.selected_towers = selected_towers
	get_tree().change_scene_to_file("res://Scenes/Rooms/main_scene.tscn")
	
	
	


func _on_primary_down_button_pressed() -> void:
	var sprite = $TowerSelectionPanel/LoadoutSelectionVBox/WeaponSelectionContainer/PrimaryWeaponContainer/VBoxContainer/TextureRect/Sprite2D
	var tween = get_tree().create_tween()
	tween.tween_property(sprite, "region_rect", Rect2(0, 64, 64, 128), 1)
