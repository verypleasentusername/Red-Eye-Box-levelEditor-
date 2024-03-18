class_name CalcCursor 


#DO NOT CHANGE | СУКА ЛОМАЕТСЯ ТОКА ПОВОД ДАЙ :: В случае чего хотябы закоментировать
static func CalcCursorXZ(Camera, Self, PlanePos ,event):
	var mouse_position = event.position
	var MouseDir = Camera.project_ray_normal(mouse_position)
	#Direction of PseudoRay from 0 by Y and X, Z of Camera
	var CameraY = Camera.global_position.y - PlanePos.y
	var Direction = MouseDir
	Direction.y = 0
	Direction = Direction.normalized()
	#Distance to Grid of PseudoRay
	#Get the Rotation needed to look in a vector of mouse Ray and gets tg 
	#of it. might be complicated to understand.
	var PointDistance = abs(tan(Self.transform.looking_at(MouseDir, Vector3.UP).basis.get_euler().x -PI/2))
	var CursorPos = Camera.global_position + Direction * PointDistance * abs(CameraY)
	CursorPos.y = PlanePos.y
	return CursorPos
	
#не есть работать хорошо. плохо! хуёво!
static func CalcCursorXY(Camera, Self, PlanePos, event):
	var mouse_position = event.position
	var MouseDir = Camera.project_ray_normal(mouse_position)
	#Direction of PseudoRay from 0 by Y and X, Z of Camera
	var CameraY = Camera.global_position.z
	var Direction = MouseDir
	Direction.z = 0
	Direction = Direction.normalized()
	#Distance to Grid of PseudoRay
	#Get the Rotation needed to look in a vector of mouse Ray and gets tg 
	#of it. might be complicated to understand.
	var smh = Self.transform.looking_at(MouseDir.rotated(Vector3.LEFT,PI/2), Vector3.FORWARD).basis.get_euler()
	var PointDistance = abs(tan(smh.x - PI/2)) 
	PointDistance = PointDistance
	var CursorPos = Camera.global_position + Direction * PointDistance * abs(CameraY)
	CursorPos.z = 0
	#var mouse_position = RelativeMousePos(ViewPortF)
	#var MouseDir = Camera.project_ray_normal(mouse_position)
	#var CursorPos = Math_U.intersect_plane(Camera.global_transform.origin,MouseDir,StartPoint,Vector3.FORWARD)
	#return CursorPos
	return CursorPos
	
#calculates where cursor is on YX plane
static func CalcCursorY(Camera, StartPoint, event):
	var mouse_position = event.position
	var MouseDir = Camera.project_ray_normal(mouse_position)
	return Math_U.closest_point_on_line(Camera.global_transform.origin, MouseDir, StartPoint, Vector3.UP)
	
	#########----------########
	
