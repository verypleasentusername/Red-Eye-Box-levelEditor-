extends Node3D


@export var Camera : Camera3D
@export var ViewPortF : SubViewport

@export var GridManaged : Node3D

@export var DebugPoint : Node3D
@export var DebugDirection:Node3D

var GridY : float

var ViewWidth : int
var ViewHeigh : int
# vector math
var PointDistance

#later change to some hightness update func
func _ready():
	GridY = GridManaged.GridY


func _process(_delta):
	
	var mouse_position = ViewPortF.get_mouse_position()
	var MouseDir = Camera.project_ray_normal(mouse_position)
	#Direction of PseudoRay from 0 by Y and X, Z of Camera
	var CameraY = Camera.global_position.y
	var Direction = MouseDir
	Direction.y = 0
	Direction = Direction.normalized()
	#Distance to Grid of PseudoRay
	#Get the Rotation needed to look in a vector of mouse Ray and gets tg 
	#of it. might be complicated to understand.
	PointDistance = abs(tan(transform.looking_at(MouseDir, Vector3.UP).basis.get_euler().x -PI/2))
	#DO NOT CHANGE | СУКА ЛОМАЕТСЯ ТОКА ПОВОД ДАЙ :: В случае чего хотябы закоментировать
	DebugPoint.transform.origin = Camera.global_position + Direction * PointDistance * abs(CameraY)
	DebugPoint.transform.origin.y = GridY
	#DebugPoint.global_rotation = MouseDir+Camera.global_rotation
	DebugDirection.rotation = transform.looking_at(DebugPoint.position, Vector3.UP).basis.get_euler()
	
	print(mouse_position)

