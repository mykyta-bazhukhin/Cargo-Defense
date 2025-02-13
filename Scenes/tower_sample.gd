extends CharacterBody2D
signal shoot_turret(pos)
var enemies = 0
@export var cost = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_tower_shoot_timer_timeout():
	shoot_turret.emit(position)


func _on_detection_range_body_entered(body):
	#print("start")
	if (enemies == 0):
		$TowerShootTimer.start()
	enemies += 1
func _on_detection_range_body_exited(body):
	enemies -= 1
	if (enemies == 0):
		#print("stop")
		$TowerShootTimer.stop()
