extends TextureRect

signal get_tower_picture(body)

func _ready():
	get_tower_picture.emit(self)
	
