extends Sprite2D

var starting_point = position
var end_point
var distance
var size = 64
var shader_material = material
var tiling_amount

func _process(delta: float) -> void:
	end_point = get_global_mouse_position()
	distance = starting_point.distance_to(end_point)
	look_at(end_point)
	tiling_amount = distance/size
	shader_material.set_shader_parameter("tiling_amount", tiling_amount)
	scale = Vector2(tiling_amount,1)
	look_at(end_point)
