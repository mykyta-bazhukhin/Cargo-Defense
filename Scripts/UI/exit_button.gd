extends Button

var og_pos

func _ready() -> void:
	og_pos = position

func _on_pressed() -> void:
	pass
	#get_tree().quit()


func _on_mouse_entered() -> void:
	og_pos = position
	var tween_start = get_tree().create_tween()
	tween_start.tween_property(self, "position", og_pos+Vector2(0,-2), 0.1)


func _on_mouse_exited() -> void:
	var tween_end = get_tree().create_tween()
	tween_end.tween_property(self, "position", og_pos, 0.1)
