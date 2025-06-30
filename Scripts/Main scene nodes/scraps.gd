extends Node2D

var ScrapScene = preload("res://Scenes/Items/scrap.tscn")
var total_scrap = 0
signal scrap_changed(total_scrap: int) #NOTE: messenger for the UI

func _ready():
	var child_array = get_children()
	for child in child_array:
		child.connect("scrap_collected", on_scrap_added)

func _on_enemies_create_scrap(pos: Vector2, val: int) -> void:
	var scrap = ScrapScene.instantiate()
	scrap.value = val
	scrap.position = pos
	scrap.connect("scrap_collected", on_scrap_added)
	add_child(scrap)

func _on_towers_scrap_used(value: int) -> void:
	total_scrap = total_scrap - value
	scrap_changed.emit(total_scrap)
	
func on_scrap_added(value: int):
	total_scrap = total_scrap + value
	scrap_changed.emit(total_scrap)
