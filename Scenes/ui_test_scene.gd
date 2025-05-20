extends Node2D

var TowerSampleScene = preload("res://Scenes/tower_sample.tscn")

var tower_selection_array: Array = [TowerSampleScene,null,null]

func _ready():
	pass

func _on_label_get_tower_1_cost(body: Variant) -> void:
	var tower_temp = tower_selection_array[0].instantiate()
	body.text = str(tower_temp.cost)
	tower_temp.free()


func _on_texture_rect_get_tower_picture(body: Variant) -> void:
	var tower_temp = tower_selection_array[0].instantiate()
	body.texture = tower_temp.get_node("Sprite2D").texture
	tower_temp.free()
