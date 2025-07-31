extends Item
@onready var door: CSGBox3D = $"../CSGCombiner3D2/Door"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	if body is Player:
		print("door opened")
		is_picked_up = true
		door.operation=CSGShape3D.OPERATION_SUBTRACTION
		queue_free()
