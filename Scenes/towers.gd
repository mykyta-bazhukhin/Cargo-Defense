extends Node2D



func _ready() -> void:
	var tower_points: Array = self.get_parent().get_node("TowerPoints").get_children()
	

func _process(delta: float) -> void:
	pass
