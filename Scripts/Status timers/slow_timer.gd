extends Timer

var og_speed

func _ready() -> void:
	start()
	get_parent().modulate = Color(0.5,1,1,1)
	og_speed = get_parent().speed
	get_parent().speed = get_parent().speed/2

func _on_timeout() -> void:
	get_parent().speed = og_speed
	get_parent().modulate = Color(1,1,1,1)
	queue_free()
