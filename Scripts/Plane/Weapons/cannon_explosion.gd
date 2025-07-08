extends Area2D
var enemies_in_range: Array

func _explode_enemies(damage) -> void:
	for enemy in enemies_in_range:
		enemy.hit(damage)

func _on_body_entered(body):
	if "hit" in body:
		enemies_in_range.append(body)

func _on_body_exited(body: Node2D) -> void:
	if "hit" in body:
		enemies_in_range.erase(body)
