extends CharacterBody2D

var mouse_pos:Vector2
var direction:Vector2
var primary_ready = true
var secondary_ready = true
var speed = 0
var distance = 0
var health = 100
const max_speed = 5000

signal shoot_primary(pos: Vector2, cooldown_time: float)
signal shoot_secondary(pos: Vector2, cooldown_time: float)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#NOTE: Input code for toggling auto fire mode
	if (Input.is_action_just_pressed("toggle_primary_auto_fire")):
		if ($PrimaryTimer.one_shot == true): #button pressed when auto fire is off
			$PrimaryTimer.one_shot = false
			$PrimaryTimer.start()
			if (primary_ready == true):
				shoot_primary.emit(global_position, $PrimaryTimer.wait_time)
				primary_ready = false
		else:
			$PrimaryTimer.one_shot = true
	if (Input.is_action_just_pressed("toggle_secondary_auto_fire")):
		if ($SecondaryTimer.one_shot == true): #button pressed when auto fire is off
			$SecondaryTimer.one_shot = false
			$SecondaryTimer.start()
			if (secondary_ready == true):
				shoot_secondary.emit(global_position, $SecondaryTimer.wait_time)
				secondary_ready = false
		else:
			$SecondaryTimer.one_shot = true
	
	mouse_pos = get_global_mouse_position()
	direction = (mouse_pos - position).normalized()
	distance = position.distance_to(mouse_pos)
	
	if (distance < 1):
		velocity = Vector2.ZERO
	else:
		speed = clamp(distance*10, 0, max_speed)
		velocity = direction*speed
	move_and_slide()

func _hit(damage):
	health -= damage
	if health <= 0:
		pass

func _on_primary_timer_timeout():
	if ($PrimaryTimer.one_shot == false):
		shoot_primary.emit(global_position, $PrimaryTimer.wait_time)
	else:
		primary_ready = true


func _on_secondary_timer_timeout():
	if ($SecondaryTimer.one_shot == false):
		shoot_secondary.emit(global_position, $SecondaryTimer.wait_time)
	else:
		secondary_ready = true
