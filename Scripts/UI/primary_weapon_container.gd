extends MarginContainer
var LaserScene = preload("res://Scenes/Plane/Weapons/laser.tscn")

var selecteble_weapons: Array
var selected_weapon_i = 0
var rect_sprite_y = 0
var belt_sprite

func _ready() -> void:
	selecteble_weapons = [LaserScene]
	belt_sprite = $VBoxContainer/TextureRect/PrimaryBeltSprite

func get_selected_primary_weapon():
	return selecteble_weapons[selected_weapon_i]

func _on_primary_up_button_pressed() -> void:
	selected_weapon_i += 1
	if (selected_weapon_i >= selecteble_weapons.size()):
		selected_weapon_i = 0
	rect_sprite_y = rect_sprite_y + 64
	var tween = get_tree().create_tween()
	tween.tween_property(belt_sprite, "region_rect", Rect2(0, rect_sprite_y, 64, 128), 0.2)
	print(selected_weapon_i)

func _on_primary_down_button_pressed() -> void:
	selected_weapon_i -= 1
	if (selected_weapon_i < 0):
		selected_weapon_i = selecteble_weapons.size()-1
	rect_sprite_y = rect_sprite_y - 64
	var tween = get_tree().create_tween()
	tween.tween_property(belt_sprite, "region_rect", Rect2(0, rect_sprite_y, 64, 128), 0.2)
	print(selected_weapon_i)
