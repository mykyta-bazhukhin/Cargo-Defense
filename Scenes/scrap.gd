extends Area2D

@export var value: int = 10
signal scrap_collected(scrap_value: int)

func _on_body_entered(body):
	scrap_collected.emit(value)
	#Global.scrap += value
	queue_free()
	
