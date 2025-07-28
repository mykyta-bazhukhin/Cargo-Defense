extends CharacterBody2D
class_name BaseTower

var enemies = 0
@export var cost:int
@export var cooldown:int
@export var health:int = 300

func _ready() -> void:
	$PlatformSprite.visible = false

func _hit(damage):
	health -= damage
	if health <= 0:
		queue_free()
		

func _on_tower_detection_range_body_entered(body):
	if (enemies == 0):
		$TowerShootTimer.start()
	enemies += 1
func _on_tower_detection_range_body_exited(body):
	enemies -= 1
	if (enemies == 0):
		$TowerShootTimer.stop()
