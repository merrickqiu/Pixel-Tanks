extends Tank

onready var shootTimer = $ShootTimer
onready var player = get_node("../Player")
func _physics_process(delta):
	point(player.global_position - global_position)
	

func _on_ShootTimer_timeout():
	aim()

func aim():
	var space_state = get_world_2d().direct_space_state
	var result = space_state.intersect_ray(position, pl)
	
