extends Node2D

var ScrapScene = preload("res://Scenes/scrap.tscn")
var total_scrap = 0
signal scrap_changed(changed_value: int)

func _ready():
	var child_array = get_children()
	for child in child_array:
		child.connect("scrap_collected", on_scrap_collected)

func _on_enemies_create_scrap(pos: Vector2, val: int) -> void:
	var scrap = ScrapScene.instantiate()
	scrap.value = val
	scrap.position = pos
	scrap.connect("scrap_collected", on_scrap_collected)
	add_child(scrap)
	
func on_scrap_collected(value: int):
	total_scrap = total_scrap + value
	scrap_changed.emit(value)
