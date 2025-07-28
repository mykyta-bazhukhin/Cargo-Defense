extends BaseTower

var enemies_array:Array

func _ready() -> void:
	super()
	$GPUParticles2D.emitting = false

func _on_tower_shoot_timer_timeout() -> void:
	for enemy in enemies_array:
		enemy.health = enemy.health-10


func _on_tower_detection_range_body_entered(body: Node2D) -> void:
	if enemies == 0:
		$GPUParticles2D.emitting = true
	super(body)
	enemies_array.append(body)


func _on_tower_detection_range_body_exited(body: Node2D) -> void:
	super(body)
	enemies_array.erase(body)
	if enemies == 0:
		$GPUParticles2D.emitting = false
