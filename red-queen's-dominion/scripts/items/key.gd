class_name Key
extends Item

@onready var area = $Area3D
@onready var collision_shape_3d = $Area3D/CollisionShape3D

@export var key_id : String

func _ready():
	area.connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	if body.has_method("pickup_key"):
		body.pickup_key(key_id)
		visible = false
		collision_shape_3d.disabled = true
		area.monitoring = false

func reset_key():
	area.monitoring = true
	collision_shape_3d.disabled = false
	visible = true
