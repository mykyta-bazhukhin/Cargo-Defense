extends PanelContainer

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	$PrimaryCooldownBar.value = $PrimaryCooldownTimer.time_left


func _on_space_plane_shoot_primary(_pos: Vector2, cooldown_time: float) -> void:
	$PrimaryCooldownBar.max_value = cooldown_time
	$PrimaryCooldownTimer.wait_time = cooldown_time
	$PrimaryCooldownTimer.start()
