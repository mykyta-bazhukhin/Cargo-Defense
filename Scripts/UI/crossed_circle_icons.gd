extends PanelContainer

func _ready() -> void:
	$PrimaryCrossedCircle.visible = false
	$SecondaryCrossedCircle.visible = false

func _on_space_plane_toggle_primary_fire_() -> void:
	$PrimaryCrossedCircle.visible = not $PrimaryCrossedCircle.visible


func _on_space_plane_toggle_secondary_fire() -> void:
	$SecondaryCrossedCircle.visible = not $SecondaryCrossedCircle.visible
