extends CharacterBody2D

var mouse_pos:Vector2
var direction:Vector2
var speed = 0
var distance = 0
const max_speed = 5000

signal shoot_primary(pos: Vector2, cooldown_time: float)
signal shoot_secondary(pos: Vector2, cooldown_time: float)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	mouse_pos = get_global_mouse_position()
	direction = (mouse_pos - position).normalized()
	distance = position.distance_to(mouse_pos)
	
	if (distance < 1):
		velocity = Vector2.ZERO
	else:
		speed = clamp(distance*10, 0, max_speed)
		velocity = direction*speed
	move_and_slide()
	
	
	#$CanvasLayer/Label.text = "speed: " + str(speed)



func _on_primary_timer_timeout():
	shoot_primary.emit(global_position, $PrimaryTimer.wait_time)


func _on_secondary_timer_timeout():
	shoot_secondary.emit(global_position, $SecondaryTimer.wait_time)
