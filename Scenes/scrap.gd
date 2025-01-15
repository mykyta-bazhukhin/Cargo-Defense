extends Area2D

@export var value: int = 10

func _on_body_entered(body):
	Global.scrap += value
	
	print(str(Global.scrap) + "+" + str(value))
	queue_free()
	

