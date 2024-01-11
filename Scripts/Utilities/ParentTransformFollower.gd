extends Camera3D

@export var Parent : Node3D

func _process(_delta):
	global_position = Parent.global_position
	global_rotation = Parent.global_rotation
