extends CharacterBody2D


var enemies = 0
@export var cost:int

func _ready() -> void:
	$PlatformSprite.visible = false

func _on_tower_detection_range_body_entered(body):
	#print("start")
	if (enemies == 0):
		$TowerShootTimer.start()
	enemies += 1
func _on_tower_detection_range_body_exited(body):
	enemies -= 1
	if (enemies == 0):
		#print("stop")
		$TowerShootTimer.stop()
