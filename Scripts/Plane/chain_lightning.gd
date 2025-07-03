extends Area2D

var end_pos
var start_pos
var bounces: int
var damage: float
var already_hit_array: Array
var in_range_array: Array
signal ready_for_shader(end_pos, start_pos)

func _ready() -> void:
	ready_for_shader.emit(end_pos, start_pos)


func _on_destroy_delay_timer_timeout() -> void:
	queue_free()
