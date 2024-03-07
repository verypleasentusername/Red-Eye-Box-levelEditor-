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
	var smh = Self.transform.looking_at(MouseDir, Vector3.UP).basis.get_euler()
	var CursorPos = Camera.global_position + Direction * PointDistance * abs(CameraY)
	CursorPos.y = Grid.GridY
	return CursorPos
	
#не есть работать хорошо. плохо! хуёво!
static func CalcCursorXY(Camera, Self, Grid,ViewPortF):
	var mouse_position = RelativeMousePos(ViewPortF)
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
	#var CursorPos = intersect_plane(Camera.global_transform.origin,MouseDir,StartPoint,Vector3.FORWARD)
	#return CursorPos
	return CursorPos

#calculates where cursor is on YX plane
static func CalcCursorY(Camera, StartPoint, PlanePos,ViewPortF):
	var mouse_position = RelativeMousePos(ViewPortF)
	var MouseDir = Camera.project_ray_normal(mouse_position)
	return closest_point_on_line(Camera.global_transform.origin, MouseDir, StartPoint, Vector3.UP)
	
	#########----------########
	
static func closest_point_on_line(ray_origin:Vector3, ray_dir:Vector3, line_origin:Vector3, line_dir:Vector3)->Vector3:
	var a:Vector3 = ray_dir.cross(line_dir)
	var w_perp:Vector3 = ray_dir.cross(a)
	return intersect_plane(line_origin, line_dir, ray_origin, w_perp)
	
static func intersect_plane(ray_origin:Vector3, ray_dir:Vector3, plane_origin:Vector3, plane_perp_dir:Vector3)->Vector3:
	var s:float = (plane_origin - ray_origin).dot(plane_perp_dir) / ray_dir.dot(plane_perp_dir)
	return ray_origin + ray_dir * s
	
static func closest_point_on_plane(point:Vector3, plane_origin:Vector3, plane_dir:Vector3)->Vector3:
	return point - (point - plane_origin).project(plane_dir)

#finds mouse position in bounds of viewport
static func RelativeMousePos(ViewPortF):
	return ViewPortF.get_mouse_position()
