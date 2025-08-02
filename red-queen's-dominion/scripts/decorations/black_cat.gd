extends CharacterBody3D

@onready var anim_player = $model/AnimationPlayer

func _ready():
	anim_player.play("SittingPose") 
