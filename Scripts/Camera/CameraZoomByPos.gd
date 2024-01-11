extends Node

@export var CameraNode : Camera3D
@export var ZoomAmount : float

var ZBuffed : float
# Called when the node enters the scene tree for the first time.
func _input(_event):
	ZBuffed = CameraNode.transform.origin.z
	if Input.is_action_pressed("ZoomIn"):
		#moving forward less and less as camera getting closer
		CameraNode.transform.origin.z -= ZoomAmount*(ZBuffed*0.25)
	elif Input.is_action_pressed("ZoomOut"):
		#moving backward more and more as camera getting futher away
		CameraNode.transform.origin.z += (ZoomAmount*(ZBuffed*0.25) - 0.05)# in case camera is 0 by z
			
