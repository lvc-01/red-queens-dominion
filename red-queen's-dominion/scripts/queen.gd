class_name Queen
extends Entity

var player_spotted:= false
@onready var navigation_agent_3d = $NavigationAgent3D
@onready var animation_player = $queen/AnimationPlayer

func _ready():
	speed = WALK_SPEED
	animation_player.play("alien_xenos_drone_SK_Xenos_Drone_skeleton|idle")

func _physics_process(delta):
	if !player_spotted:
		patrol(delta)
	else:
		chase_player(delta)
	
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, safe_margin)

	move_and_slide()
	
func patrol(delta):
	print("Queen is looking for Alice.")
	
	
func chase_player(delta):
	print("Queen is chasing Alice.")
	animation_player.play("alien_xenos_drone_SK_Xenos_Drone_skeleton|run1")
	#head to last known position, if player is there, they die, else go back to patrolling

func _on_detection_area_body_entered(body):
	if body is Player:
		player_spotted = true


func _on_detection_area_body_exited(body):
	#head to last known position
	if body is Player:
		player_spotted = false
	
	
func _on_player_kill_zone_body_entered(body):
	if body is Player:
		body.die()
