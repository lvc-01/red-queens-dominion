extends Area3D

@export var required_key : String

func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		if body.has_key(required_key):
			get_node("AnimationPlayer").play("door_open")


func _on_body_exited(body: Node3D) -> void:
	if body is Player:
		if body.has_key(required_key):
			get_node("AnimationPlayer").play("door_close")
