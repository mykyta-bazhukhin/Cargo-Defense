extends TextureButton


func _on_pressed() -> void:
	get_parent().get_parent().visible = false
