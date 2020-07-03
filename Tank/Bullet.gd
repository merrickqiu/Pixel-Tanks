extends KinematicBody2D


const SPEED = 200
const BOUNCES = 1

var velocity = Vector2.ZERO
var bounces_left = BOUNCES

func start(pos, dir):
	rotation = dir
	position = pos
	velocity = Vector2(SPEED, 0).rotated(rotation) 
	
func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		bounces_left -= 1
		if bounces_left < 0:
			queue_free()
		velocity = velocity.bounce(collision.normal)


func _on_Area2D_area_entered(area):
	queue_free()
