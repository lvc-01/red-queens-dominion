extends Node3D

@onready var audio: AudioStreamPlayer3D = $AudioStreamPlayer3D

func _ready():
	audio.stream.loop = true
	audio.play()
