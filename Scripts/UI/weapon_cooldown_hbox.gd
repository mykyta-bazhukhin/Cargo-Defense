extends HBoxContainer

var plane_primary_timer
var plane_secondary_timer

func _ready() -> void:
	await get_node("../..").ready
	$PrimaryCooldownBar.max_value = plane_primary_timer.wait_time
	$PrimaryCooldownTimer.wait_time = plane_primary_timer.wait_time
	$PrimaryCooldownTimer.start()

	$SecondaryCooldownBar.max_value = plane_secondary_timer.wait_time
	$SecondaryCooldownTimer.wait_time = plane_secondary_timer.wait_time
	$SecondaryCooldownTimer.start()

func _process(_delta: float) -> void:
	$PrimaryCooldownBar.value = $PrimaryCooldownTimer.time_left
	$SecondaryCooldownBar.value = $SecondaryCooldownTimer.time_left


func _on_space_plane_shoot_primary(_pos: Vector2, cooldown_time: float) -> void:
	$PrimaryCooldownTimer.wait_time = cooldown_time
	$PrimaryCooldownTimer.start()


func _on_space_plane_shoot_secondary(_pos: Vector2, cooldown_time: float) -> void:
	$SecondaryCooldownTimer.wait_time = cooldown_time
	$SecondaryCooldownTimer.start()
