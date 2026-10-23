extends Enemy
class_name AAAAA


func _update(delta: float)->void:
	pass
	

func update_move(delta : float)->void:
	pass
	

func die()->void:
	queue_free()
	
func hurt()->void:
	
	health -= 1
	
	for i in range(5):
		sprite.scale = Vector2(0.1, 0.1)
		await(get_tree().create_timer(0.1).timeout)
		sprite.scale = Vector2(0.3, 0.3)
		await(get_tree().create_timer(0.1).timeout)
	

func _on_hurtbox_area_entered(area: Area2D) -> void:
	print_debug("Detected Collision")
	if health > 0:
		hurt()
	else:
		die()
