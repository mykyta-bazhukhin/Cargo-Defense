extends Node2D

func _ready() -> void:
	$Sprite2D.end_point = $Marker2D.position
