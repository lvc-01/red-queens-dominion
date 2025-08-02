extends Node3D

@export var pause_menu: Control


var is_paused := false

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS   # allows input during pause
	set_process_input(true)
	get_tree().paused = false                 # make sure game starts unpaused
	pause_menu.visible = false


func _input(event):
	if event.is_action_pressed("pause_game"):
		toggle_pause()


func toggle_pause():
	is_paused = !is_paused
	get_tree().paused = is_paused
	pause_menu.visible = is_paused
	print("Paused:", is_paused)
