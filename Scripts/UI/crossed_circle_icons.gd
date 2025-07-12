extends PanelContainer

func _ready() -> void:
	$PrimaryCrossedCircle.visible = false
	$SecondaryCrossedCircle.visible = false

func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("toggle_primary_auto_fire")):
		$PrimaryCrossedCircle.visible = not $PrimaryCrossedCircle.visible
	if (Input.is_action_just_pressed("toggle_secondary_auto_fire")):
		$SecondaryCrossedCircle.visible = not $SecondaryCrossedCircle.visible
