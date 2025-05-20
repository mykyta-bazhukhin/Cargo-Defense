extends Label

signal get_tower1_cost(body)

func _ready():
	get_tower1_cost.emit(self)
