extends CharacterBody2D
class_name BaseTower

var occupied_point
var enemies = 0
@export var cost:int
@export var cooldown:int
@export var max_health:int = 300
var health

func _ready() -> void:
	health = max_health
	$PlatformSprite.visible = false
	$PlatformSprite.frame = 0

func hit(damage):
	health -= damage
	$HitFlashAnimation.stop()
	$HitFlashAnimation.play("hit")
	if health <= (max_health/3):
		$PlatformSprite.frame = 2
	elif health <= max_health*(2.0/3.0):
		$PlatformSprite.frame = 1
	else:
		$PlatformSprite.frame = 0
		
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
