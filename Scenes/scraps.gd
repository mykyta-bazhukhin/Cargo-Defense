extends Node2D

var ScrapScene = preload("res://Scenes/scrap.tscn")

func _on_enemies_create_scrap(pos: Vector2, val: int) -> void:
	var scrap = ScrapScene.instantiate()
	scrap.value = val
	scrap.position = pos
	add_child(scrap)
