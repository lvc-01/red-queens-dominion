class_name Queen
extends Entity

var player_spotted:= false
var target_position: Vector3

@onready var nav_agent = $NavigationAgent3D
@onready var player = get_tree().get_first_node_in_group("Player")
@onready var patrol_timer = $PatrolTimer
@onready var audio = $AudioStreamPlayer3D


func _ready():
	speed = WALK_SPEED
	#update later and include y for stairs
	#target_position = Vector3(randf_range(-42, 150), 11, randf_range(-37, 1))
	#patrol_timer.start(60)


#func _physics_process(delta):
	#if not is_on_floor():
		#velocity += get_gravity() * delta
		#
	#if !player_spotted:
		#patrol()
	#else:
		#chase_player()
#
	#var direction = (nav_agent.get_next_path_position() - global_position).normalized()
	#velocity = velocity.lerp(direction*speed, delta*10)
	#move_and_slide()
	
func patrol():
	#look_at((nav_agent.get_next_path_position() - global_position).normalized(), Vector3.UP)
	nav_agent.target_position = target_position
	if(abs(target_position.x - position.x)<=5 and abs(target_position.z - position.z)<=5):
		calculate_next_position()
	
	
func chase_player():
	#look_at(player.position, Vector3.UP)
	nav_agent.target_position = player.global_position


func _on_detection_area_body_entered(body):
	if body is Player:
		player_spotted = true
		speed = SPRINT_SPEED
		audio.play()


func _on_detection_area_body_exited(body):
	if body is Player:
		player_spotted = false
		target_position = body.global_position
		speed = WALK_SPEED
	
	
func _on_player_kill_zone_body_entered(body):
	if body is Player:
		body.die()
		

func _on_patrol_timer_timeout():
	calculate_next_position()
	
	
func calculate_next_position():
	print("Calculating new path...")
	var player_position = player.global_position
	target_position = Vector3(randf_range(player_position.x - 40, player_position.x + 40), 		
	11, randf_range(player_position.z - 40, player_position.z + 40))
	
	#likely need to add y to the mix later, update to account for world boundaries
	clamp(target_position.x, -42, 150)
	clamp(target_position.z, -37, 1)
	patrol_timer.start(60)
