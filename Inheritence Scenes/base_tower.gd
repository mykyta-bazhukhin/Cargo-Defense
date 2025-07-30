extends CharacterBody2D
class_name BaseTower

var occupied_point
var enemies = 0
@export var cost:int
@export var cooldown:int
@export var health:int = 300

func _ready() -> void:
	$PlatformSprite.visible = false

func hit(damage):
	health -= damage
	$HitFlashAnimation.stop()
	$HitFlashAnimation.play("hit")
	if health <= 0:
		occupied_point.add_to_group("Not Occupied")
		queue_free()
		

func _on_tower_detection_range_body_entered(body):
	if (enemies == 0):
		$TowerShootTimer.start()
	enemies += 1
func _on_tower_detection_range_body_exited(body):
	enemies -= 1
	if (enemies == 0):
		$TowerShootTimer.stop()
