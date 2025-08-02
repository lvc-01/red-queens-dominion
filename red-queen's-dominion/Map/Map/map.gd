extends Node3D

@export var pause_menu: Control
@export var reset_timer: Timer
@export var player: Player

var is_paused := false

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS   # allows input during pause
	set_process_input(true)
	get_tree().paused = false                 # make sure game starts unpaused
	pause_menu.visible = false
	reset_timer.timeout.connect(Callable(self, "time_up"))


func _input(event):
	if event.is_action_pressed("pause"):
		toggle_pause()


func toggle_pause():
	is_paused = !is_paused
	get_tree().paused = is_paused
	pause_menu.visible = is_paused
	print("Paused:", is_paused)

func resetDoors():
	for door in get_tree().get_nodes_in_group("door"):
		door.reset_door()

func resetKeys():
	for key in get_tree().get_nodes_in_group("keys"):
		key.reset_key()

func time_up():
	player.resetPlayer()
	resetDoors()
	resetKeys()
