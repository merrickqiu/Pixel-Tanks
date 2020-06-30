extends Node

func _ready():
	#OS.window_fullscreen = true
	pass

func _input(event):
	if event.is_action_pressed("toggle_fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen
