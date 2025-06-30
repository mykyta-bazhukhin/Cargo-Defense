extends Label

var total_scrap_ui = 0

func _ready():
	text = str(total_scrap_ui)

func _on_scraps_scrap_changed(total_scrap: int) -> void:
	text = str(total_scrap)
	total_scrap_ui = total_scrap
