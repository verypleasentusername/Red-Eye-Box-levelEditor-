extends RefCounted 
class_name CalcCursor 


#DO NOT CHANGE | СУКА ЛОМАЕТСЯ ТОКА ПОВОД ДАЙ :: В случае чего хотябы закоментировать
static func CalcCursorXZ(Camera, Self, Grid,ViewPortF):
	var mouse_position = RelativeMousePos(ViewPortF)
	var MouseDir = Camera.project_ray_normal(mouse_position)
	#Direction of PseudoRay from 0 by Y and X, Z of Camera
	var CameraY = Camera.global_position.y - Grid.GridY
	var Direction = MouseDir
	Direction.y = 0
	Direction = Direction.normalized()
	#Distance to Grid of PseudoRay
	#Get the Rotation needed to look in a vector of mouse Ray and gets tg 
	#of it. might be complicated to understand.
	var PointDistance = abs(tan(Self.transform.looking_at(MouseDir, Vector3.UP).basis.get_euler().x -PI/2))
	var CursorPos = Camera.global_position + Direction * PointDistance * abs(CameraY)
	CursorPos.y = Grid.GridY
	return CursorPos
	
static func CalcCursorY(Camera, Self, Grid,ViewPortF):
	var mouse_position = RelativeMousePos(ViewPortF)
	var MouseDir = -Camera.global_transform.basis.z
	#Direction of PseudoRay from 0 by Y and X, Z of Camera
	var CameraY = Camera.global_position.y - Grid.GridY
	var Direction = MouseDir
	Direction.y = 0
	Direction = Direction.normalized()
	#Distance to Grid of PseudoRay
	#Get the Rotation needed to look in a vector of mouse Ray and gets tg 
	#of it. might be complicated to understand.
	var PointDistance = abs(tan(Self.transform.looking_at(MouseDir, Vector3.UP).basis.get_euler().x -PI/2))
	var CursorPos = Camera.global_position + Direction * PointDistance * abs(CameraY)
	CursorPos.y = Grid.GridY
	print(MouseDir)
	return CursorPos
	

#finds mouse position in bounds of viewport
static func RelativeMousePos(ViewPortF):
	return ViewPortF.get_mouse_position()
