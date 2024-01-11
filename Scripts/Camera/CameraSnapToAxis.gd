extends Node

@export var PivotX:Node3D
@export var PivotY:Node3D

#camera we set projection mode to
@export var Camera: Camera3D

func _input(_event):
	if Input.is_action_just_pressed("Snap0"):
		PivotX.rotation = Vector3.ZERO
		PivotY.rotation = Vector3.ZERO
		Camera.projection = Camera3D.PROJECTION_ORTHOGONAL
		
	if Input.is_action_just_pressed("SnapCancel"):
		CancelSnap()
		
#If snapping is canceled, Projection is back to normal
func CancelSnap():
	Camera.projection = Camera3D.PROJECTION_PERSPECTIVE
