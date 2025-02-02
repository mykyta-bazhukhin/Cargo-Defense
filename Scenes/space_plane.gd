extends CharacterBody2D

var mouse_pos = Vector2(0,0)
var mouse_pos_x = 0
var mouse_pos_y = 0
var speed = 0
signal shoot_primary(pos)
signal shoot_secondary(pos)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_and_slide()
	mouse_pos = get_global_mouse_position()
	mouse_pos_x = get_global_mouse_position().x
	mouse_pos_y = get_global_mouse_position().y
	
	
	var direction = (mouse_pos - position).normalized()
	speed = position.distance_to(mouse_pos)*100
	#speed = sqrt(pow(position.x-mouse_pos_x, 2) + pow(position.y-mouse_pos_y, 2))*100
	velocity = direction*speed
	
	



func _on_primary_timer_timeout():
	shoot_primary.emit(global_position)


func _on_secondary_timer_timeout():
	shoot_secondary.emit(global_position)
