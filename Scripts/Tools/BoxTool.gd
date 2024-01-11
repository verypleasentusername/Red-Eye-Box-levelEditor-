extends Node3D

@export var Camera : Node3D
@export var GridManaged : Node3D
@export var DebugPoint : Node3D

var GridY : float

# vector math
var PointDistance

#later change to some hightness update func
func _ready():
	GridY = GridManaged.GridY

func _process(_delta):
	PointDistance = abs(tan(Camera.global_rotation.x- PI/2))
	
	var CameraY = Camera.global_position.y
	var Direction = -Camera.global_basis.z

	Direction.y = 0
	Direction = Direction.normalized()
	
	#DO NOT CHANGE | СУКА ЛОМАЕТСЯ ТОКА ПОВОД ДАЙ :: В случае чего хотябы закоментировать
	DebugPoint.transform.origin = Camera.global_position + Direction * PointDistance * CameraY
	DebugPoint.transform.origin.y = GridY
	
	
	#print(Direction)
	print("Point is")
	print(PointDistance)
	print("Camera is(Rot)")
	print(Camera.global_rotation_degrees.x+90)
