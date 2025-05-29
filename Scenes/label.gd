extends Label

signal get_tower1_cost(body)
var total_scrap = 0

func _ready():
	text = str(total_scrap)


func _on_scraps_scrap_changed(changed_value: Variant) -> void:
	total_scrap = total_scrap + changed_value
	text = str(total_scrap)
