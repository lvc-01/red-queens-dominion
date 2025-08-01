class_name Player
extends Entity

const JUMP_VELOCITY = 4.5
const SENSITIVITY = 0.003

#Bob
const BOB_FREQ = 2.0
const BOB_AMP = 0.08
var t_bob = 0.0
 
#Inventory
var inventory_keys:Array[String] =[]

@onready var head: Node3D = $Head
@onready var camera: Camera3D = $Head/Camera3D

#Mouse movement
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * SENSITIVITY)
		camera.rotate_x(-event.relative.y * SENSITIVITY)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-40), deg_to_rad(60))

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	#Sprint
	if Input.is_action_pressed("sprint"):
		speed = SPRINT_SPEED
	else:
		speed = WALK_SPEED

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "forward", "back")
	var direction := (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = 0.0
		velocity.z = 0.0

#bob
	t_bob += delta * velocity.length() * float(is_on_floor())
	camera.transform.origin = _headbob(t_bob)

	move_and_slide()

func _headbob(time) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * BOB_FREQ) * BOB_AMP
	pos.x = cos(time * BOB_FREQ / 2) * BOB_AMP
	return pos

func pickup_key(key_id:String):
	if key_id not in inventory_keys:
		inventory_keys.append(key_id)
		print("key: ", key_id)
		
func has_key(key_id:String):
	return key_id in inventory_keys
	
#func _input(event):
	#if event.is_action_pressed("interact"):
		#var from = head.global_transform.origin
		#var to = from + -head.transform.basis.z * 2.5  # forward
		#var space_state = get_world_3d().direct_space_state
		#var query = PhysicsRayQueryParameters3D.create(from, to)
		#query.exclude = [self] 
		#
		#var result = space_state.intersect_ray(query)
		#print(result.collider)
		#
		#if result and result.collider and result.collider.has_method("try_open"):
			#print("checkw")
			#result.collider.try_open(self)
