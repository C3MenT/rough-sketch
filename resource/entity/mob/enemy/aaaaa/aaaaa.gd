extends Enemy
class_name AAAAA

## The delay between enemy shots in seconds
var shoot_interval : float = 2.0



func _ready() -> void:
	super._ready()
	# Set the mob timer time to the shoot interval and start its loop
	timer.start(shoot_interval)



func shoot()->void:
	var player_ref : Player = get_player()
	if !player_ref:
		return
	var new_projectile : Projectile = ProjectileLibrary.a_projectile.instantiate()
	get_parent().add_child(new_projectile)
	new_projectile.global_position = global_position
	var direction : Vector2 = global_position.direction_to(player_ref.global_position)
	new_projectile.set_movement_data(direction)



# AAAAA will just call shoot every time its mob timer counts down
func _on_timer_timeout() -> void:
	for i in range(3):
		shoot()
		await(get_tree().create_timer(0.1).timeout)
