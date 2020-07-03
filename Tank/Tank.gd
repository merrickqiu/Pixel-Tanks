class_name Tank
extends KinematicBody2D

signal died

export(int, 0, 1000) var MAX_SPEED = 100
export(int, 0, 1000) var ACCELERATION = 200
export(int, 0, 1000) var FRICTION = 400

export(float, 0.0, 20.0, 0.1) var MAX_ANGULAR_VELOCITY = 5.0
export(float, 0.0, 20.0, 0.1) var ANGULAR_ACCELERATION = 10.0
export(float, 0.0, 20.0, 0.1) var ANGULAR_FRICTION = 20.0

var bullet = preload("res://Tank/Bullet.tscn")
var velocity = Vector2.ZERO
var angular_velocity = 0
var gun_dir = Vector2.UP

onready var gun = $TankSprite/Gun
onready var animationPlayer = $AnimationPlayer
onready var tankSprite = $TankSprite

func move(input_velocity, input_angular_velocity, delta):
	# Set rotation with acceleration and friction.
	if input_angular_velocity != 0:
		angular_velocity = move_toward(angular_velocity, input_angular_velocity, ANGULAR_ACCELERATION * delta)
	else:
		angular_velocity = move_toward(angular_velocity, 0, ANGULAR_FRICTION * delta)
	rotation += angular_velocity * delta
	
	# Set velocity with acceleration and friction.
	if input_velocity != Vector2.ZERO:
		velocity = velocity.move_toward(input_velocity, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		
	# Change velocity so that it matches tank direction
	var tank_direction = Vector2.UP.rotated(rotation)
	velocity = velocity.project(tank_direction)
	
	# Move
	velocity = move_and_slide(velocity)


func point(dir):
	gun_dir = dir
	gun.rect_rotation = rad2deg(dir.angle() - rotation + PI/2)


func shoot():
	var b = bullet.instance()
	b.start(tankSprite.global_position + 20 * gun_dir.normalized(), gun_dir.angle())
	get_parent().add_child(b)


func _on_Area2D_area_entered(_area):
	emit_signal("died")
	queue_free()
