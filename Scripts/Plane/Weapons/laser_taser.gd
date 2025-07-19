extends Area2D

var bounces = 5
var chain_damage = 3
var chain_range = 300
var direction = Vector2.UP
var speed = 400
var damage = 4
var icon = "res://Sprites/UI stuff/laser icon.png"
var cooldown = 0.8


func _process(delta):
	position += direction * speed * delta

func _ready() -> void:
	pass
"""
func find_enemies_in_range(hit_body):
	var enemies_in_range: Array
	for enemy in tot_enemies:
		if (enemy.position.distance_to(hit_body.position) <= chain_range):
			enemies_in_range.append(enemy)
	#enemies_in_range.erase(hit_body)
	already_hit_dict.set(hit_body, 0)
	return enemies_in_range
"""

func _on_body_entered(body):
	if "hit" in body:
		#print(body.position)
		get_parent()._create_chain_lightning(body, body.position, bounces, chain_range, chain_damage, {})
		$Sprite2D.visible = false
		speed = 0
		body.hit(damage)
		disconnect("body_entered", _on_body_entered)
	else:
		queue_free()
	
	"""
	var end_pos
	var target_body
	var cur_tased_body = body
	if "hit" in cur_tased_body:
		for i in range(bounces):
			enemies_in_range = find_enemies_in_range(cur_tased_body)
			target_body = calculate_chain(cur_tased_body)
			if target_body == null:
				break
			target_body.hit(chain_damage)
			end_pos = target_body.position
			get_parent()._create_chain_lightning(cur_tased_body.position, end_pos)
			cur_tased_body = target_body
		body.hit(damage)
	queue_free()
	"""

func _on_timer_timeout_timeout():
	queue_free()
