extends Node

@export var sens : float = 0.5
@export var rot_max = 90
@export var rot_min = -90

var look_rot : Vector3

@export var PivotY : Node3D
@export var PivotX : Node3D

func _physics_process(_delta):
	#Rotating
	PivotX.rotation_degrees.x = -look_rot.x
	PivotY.rotation_degrees.y = look_rot.y
	
	#print(look_rot)


func _input(event):
	#checking if Rotating Camera around Pivot should be done
	if (event is InputEventMouseMotion) and Input.is_action_pressed("ViewRotate") and not Input.is_action_pressed("ShiftMove"): 
		look_rot.y -= event.relative.x * sens
		look_rot.x -= event.relative.y * sens
		look_rot.x = clamp(look_rot.x,rot_min,rot_max)
