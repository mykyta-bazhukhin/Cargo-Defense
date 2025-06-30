extends CharacterBody2D

@export var cost = 3

func _ready() -> void:
	$PlatformSprite.visible = false
