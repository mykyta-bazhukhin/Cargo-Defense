extends Sprite2D

var start_pos
var end_pos
var distance
var size = 64
var shader_material = material
var tiling_amount

func _ready() -> void:
	pass

func _on_chain_lightning_ready_for_shader(end_pos: Variant, start_pos: Variant) -> void:
	print(end_pos)
	print(start_pos)
	print(distance)
	print(tiling_amount)
	distance = start_pos.distance_to(end_pos)
	look_at(end_pos)
	tiling_amount = distance/size
	shader_material.set_shader_parameter("tiling_amount", tiling_amount)
	scale = Vector2(tiling_amount,1)
	look_at(end_pos)
