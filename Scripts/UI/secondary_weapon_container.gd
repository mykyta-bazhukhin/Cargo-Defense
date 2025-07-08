extends MarginContainer
var RocketScene = preload("res://Scenes/Plane/Weapons/rocket.tscn")
var CannonBallScene = preload("res://Scenes/Plane/Weapons/cannon_ball.tscn")

var selecteble_weapons: Array
var selected_weapon_i = 0
var rect_sprite_y = 0
var belt_sprite

func _ready() -> void:
	selecteble_weapons = [RocketScene, CannonBallScene]
	belt_sprite = $VBoxContainer/TextureRect/SecondaryBeltSprite

func get_selected_secondary_weapon():
	return selecteble_weapons[selected_weapon_i]

func _on_secondary_up_button_pressed() -> void:
	selected_weapon_i += 1
	if (selected_weapon_i >= selecteble_weapons.size()):
		selected_weapon_i = 0
	rect_sprite_y = rect_sprite_y + 64
	var tween = get_tree().create_tween()
	tween.tween_property(belt_sprite, "region_rect", Rect2(0, rect_sprite_y, 64, 128), 0.2)

func _on_secondary_down_button_pressed() -> void:
	selected_weapon_i -= 1
	if (selected_weapon_i < 0):
		selected_weapon_i = selecteble_weapons.size()-1
	rect_sprite_y = rect_sprite_y - 64
	var tween = get_tree().create_tween()
	tween.tween_property(belt_sprite, "region_rect", Rect2(0, rect_sprite_y, 64, 128), 0.2)
