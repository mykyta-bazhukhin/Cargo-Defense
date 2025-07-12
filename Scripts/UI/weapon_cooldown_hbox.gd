extends HBoxContainer

var plane_primary_timer
var plane_secondary_timer

func _ready() -> void:
	await get_node("../..").ready
	$PrimaryVBox/CrossedCircle.visible = false
	$%PrimaryCooldownBar.max_value = plane_primary_timer.wait_time
	$PrimaryCooldownTimer.wait_time = plane_primary_timer.wait_time
	$PrimaryCooldownTimer.start()

	$SecondaryVBox/CrossedCircle.visible = false
	$%SecondaryCooldownBar.max_value = plane_secondary_timer.wait_time
	$SecondaryCooldownTimer.wait_time = plane_secondary_timer.wait_time
	$SecondaryCooldownTimer.start()

func _process(_delta: float) -> void:
	$%PrimaryCooldownBar.value = $PrimaryCooldownTimer.time_left
	$%SecondaryCooldownBar.value = $SecondaryCooldownTimer.time_left

	if (Input.is_action_just_pressed("toggle_primary_auto_fire")):
		$PrimaryVBox/CrossedCircle.visible = not $PrimaryVBox/CrossedCircle.visible
	if (Input.is_action_just_pressed("toggle_secondary_auto_fire")):
		$SecondaryVBox/CrossedCircle.visible = not $SecondaryVBox/CrossedCircle.visible


func _on_space_plane_shoot_primary(_pos: Vector2, cooldown_time: float) -> void:
	$PrimaryCooldownTimer.wait_time = cooldown_time
	$PrimaryCooldownTimer.start()


func _on_space_plane_shoot_secondary(_pos: Vector2, cooldown_time: float) -> void:
	$SecondaryCooldownTimer.wait_time = cooldown_time
	$SecondaryCooldownTimer.start()
