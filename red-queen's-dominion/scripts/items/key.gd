class_name key
extends Item

@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D

@export var key_id : String;

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	if body.has_method("pickup_key"):
		body.pickup_key(key_id)
		visible = false
		collision_shape_3d.disabled = true
