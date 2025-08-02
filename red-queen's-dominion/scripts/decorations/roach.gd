extends CharacterBody3D

@onready var anim_player = $model/AnimationPlayer

func _ready():
	anim_player.play("giant_cockroach_armature|idle")
	
func _physics_process(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta
