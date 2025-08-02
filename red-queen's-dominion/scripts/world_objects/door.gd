class_name Door
extends Area3D

@export var required_key = "none"
@onready var door_mesh: MeshInstance3D = $StaticBody3D/door
@onready var open_sound = $DoorSound 

var is_open = false
var original_transform: Transform3D

func _ready():
	print(original_transform)
	if door_mesh != null:
		original_transform = door_mesh.transform 
		print(original_transform)


func _on_body_entered(body: Node3D) -> void:
	if body is Player and !is_open:
		var anim_player = get_node("AnimationPlayer")
		if anim_player.current_animation != "door_open":
			if required_key == "none" or body.has_key(required_key):
				anim_player.play("door_open")
				open_sound.play()
				is_open = true

func reset_door():
	print("reset door")
	is_open = false
	if door_mesh != null:
		door_mesh.transform = original_transform
	else:
		print("Warning: door_mesh is null")

#func _on_body_exited(body: Node3D) -> void:
	#if body is Player:
		#var anim_player = get_node("AnimationPlayer")
		#if anim_player.current_animation != "door_close":
			#if required_key == "none" or body.has_key(required_key):
				#anim_player.play("door_close")
