class_name Math_U

enum Axis { X, Y, Z }

static func square(value:float)->float:
	return value * value
static func closest_point_on_line(ray_origin:Vector3, ray_dir:Vector3, line_origin:Vector3, line_dir:Vector3)->Vector3:
	var a:Vector3 = ray_dir.cross(line_dir)
	var w_perp:Vector3 = ray_dir.cross(a)
	return intersect_plane(line_origin, line_dir, ray_origin, w_perp)
	
static func intersect_plane(ray_origin:Vector3, ray_dir:Vector3, plane_origin:Vector3, plane_perp_dir:Vector3)->Vector3:
	var s:float = (plane_origin - ray_origin).dot(plane_perp_dir) / ray_dir.dot(plane_perp_dir)
	return ray_origin + ray_dir * s
	
static func closest_point_on_plane(point:Vector3, plane_origin:Vector3, plane_dir:Vector3)->Vector3:
	return point - (point - plane_origin).project(plane_dir)
	
	###----НАВЕРНОЕ УДАЛИТЬ ЗА ЕБЕЙШИМ КОЛИЧЕСТВОМ КОДА КОТОРЫЙ Я НИХУИЩА НЕ ПОНИМАЮ---###
class IntersectTriangleResult:
	var position:Vector3
	var normal:Vector3
	
static func intersect_triangle(ray_origin:Vector3, ray_dir:Vector3, p0:Vector3, p1:Vector3, p2:Vector3)->IntersectTriangleResult:
	#Godot uses clockwise winding
	var tri_area_x2:Vector3 = Math_U.triangle_area_x2(p0, p1, p2)
	
	var p_hit:Vector3 = Math_U.intersect_plane(ray_origin, ray_dir, p0, tri_area_x2)
	if !p_hit.is_finite():
		return null
	
	if Math_U.triangle_area_x2(p_hit, p0, p1).dot(tri_area_x2) < 0:
		return null
	if Math_U.triangle_area_x2(p_hit, p1, p2).dot(tri_area_x2) < 0:
		return null
	if Math_U.triangle_area_x2(p_hit, p2, p0).dot(tri_area_x2) < 0:
		return null
		
	var result:IntersectTriangleResult = IntersectTriangleResult.new()
	result.position = p_hit
	result.normal = tri_area_x2.normalized()
	return result
	
static func triangle_area_x2(p0:Vector3, p1:Vector3, p2:Vector3)->Vector3:
	return (p2 - p0).cross(p1 - p0)
	
static func face_area_x2(points:PackedVector3Array)->Vector3:
	if points.size() <= 1:
		return Vector3.ZERO
	
	var result:Vector3
	var p0:Vector3 = points[0]
	
	for i in range(1, points.size() - 1):
		var p1:Vector3 = points[i]
		var p2:Vector3 = points[i + 1]
		
		result += (p2 - p0).cross(p1 - p0)
	
	return result
	
static func face_area_x2_2d(points:PackedVector2Array)->float:
	if points.size() <= 1:
		return 0
	
	var result:float
	var p0:Vector2 = points[0]
	
	for i in range(1, points.size() - 1):
		var p1:Vector2 = points[i]
		var p2:Vector2 = points[i + 1]
		
		result += triange_area_2x_2d(p1 - p0, p2 - p0)
	
	return result
	
static func triange_area_2x_2d(a:Vector2, b:Vector2)->float:
	return a.x * b.y - a.y * b.x
	
static func fit_plane(points:PackedVector3Array)->Plane:
	var normal:Vector3 = face_area_x2(points).normalized()
	return Plane(normal, points[0])

static func snap_to_best_axis_normal(vector:Vector3)->Vector3:
	if abs(vector.x) > abs(vector.y) and abs(vector.x) > abs(vector.z):
		return Vector3(1, 0, 0) if vector.x > 0 else Vector3(-1, 0, 0)
	elif abs(vector.y) > abs(vector.z):
		return Vector3(0, 1, 0) if vector.y > 0 else Vector3(0, -1, 0)
	else:
		return Vector3(0, 0, 1) if vector.z > 0 else Vector3(0, 0, -1)

static func get_longest_axis(vector:Vector3)->Axis:
	if abs(vector.x) > abs(vector.y) and abs(vector.x) > abs(vector.z):
		return Axis.X
	elif abs(vector.y) > abs(vector.z):
		return Axis.Y
	else:
		return Axis.Z
		
static func calc_bounds(points:PackedVector3Array)->AABB:
	if points.is_empty():
		return AABB(Vector3.ZERO, Vector3.ZERO)
	
	var result:AABB = AABB(points[0], Vector3.ZERO)
	for i in range(1, points.size()):
		result = result.expand(points[i])
	return result
	
static func polygon_intersects_frustum(points:PackedVector3Array, frustum:Array[Plane])->bool:
	var points_i:PackedVector3Array = points
	
	for plane in frustum:
		points_i = clip_polygon(points_i, plane)
		if points_i.is_empty():
			return false
	
	return true
	
static func clip_polygon(points:PackedVector3Array, plane:Plane)->PackedVector3Array:
	var result:PackedVector3Array
	#Cut at planr intersection
	var points_on_or_over:PackedVector3Array
	
	for p_idx0 in points.size():
		var p_idx1:int = wrap(p_idx0 + 1, 0, points.size())
		
		var p0:Vector3 = points[p_idx0]
		var p1:Vector3 = points[p_idx1]
		
		var on0:bool = plane.has_point(p0)
		var over0:bool = plane.is_point_over(p0)
		var under0:bool = !on0 && !over0
		var on1:bool = plane.has_point(p1)
		var over1:bool = plane.is_point_over(p1)
		var under1:bool = !on1 && !over1
		
		if on0 || over0:
			points_on_or_over.append(p0)
		
		if (under0 && over1) || (over0 && under1):
			points_on_or_over.append(plane.intersects_segment(p0, p1))
	return points_on_or_over
	
static func flip_plane(plane:Plane)->Plane:
	return Plane(-plane.normal, plane.get_center())

static func get_loops_from_segments_2d(segments:PackedVector2Array)->Array[Loop2D]:
	#print("segments %s" % segments)
	var loops:Array[Loop2D] = []

	var seg_stack:Array[Segment2d] = []
	for i in range(0, segments.size(), 2):
		seg_stack.append(Segment2d.new(segments[i], segments[i + 1]))
	
#	print("segs %s" % str(seg_stack))
	
	while !seg_stack.is_empty():
		var loop:Loop2D = extract_loop_2d(seg_stack)
		loops.append(loop)
	#print("result %s" % str(loops))
	return loops
	
class Segment2d extends RefCounted:
	var p0:Vector2
	var p1:Vector2
	
	func _init(p0:Vector2, p1:Vector2):
		self.p0 = p0
		self.p1 = p1
		
	func reverse()->Segment2d:
		return Segment2d.new(p1, p0)
		
	func _to_string():
		return "[%s %s]" % [p0, p1]
	
static func extract_loop_2d(seg_stack:Array[Segment2d])->Loop2D:
	var segs_sorted:Array[Segment2d] = []
	var seg_tail = seg_stack.pop_back()
	segs_sorted.append(seg_tail)
	var seg_head = seg_tail
	
	while !seg_stack.is_empty():
		var found_seg:bool = false
		for s_idx in seg_stack.size():
			var cur_seg:Segment2d = seg_stack[s_idx]
			
			if cur_seg.p0.is_equal_approx(seg_tail.p1):
				#print("matching %s with %s" % [seg_tail, cur_seg])
				segs_sorted.append(cur_seg)
				seg_stack.remove_at(s_idx)
				seg_tail = cur_seg
				found_seg = true
				break
			elif cur_seg.p1.is_equal_approx(seg_tail.p1):
				#print("matching %s with %s" % [seg_tail, cur_seg])
				cur_seg = cur_seg.reverse()
				segs_sorted.append(cur_seg)
				seg_stack.remove_at(s_idx)
				seg_tail = cur_seg
				found_seg = true
				break
			elif cur_seg.p1.is_equal_approx(seg_head.p0):
				#print("matching %s with %s" % [seg_head, cur_seg])
				segs_sorted.insert(0, cur_seg)
				seg_stack.remove_at(s_idx)
				seg_head = cur_seg
				found_seg = true
				break
			elif cur_seg.p0.is_equal_approx(seg_head.p0):
				#print("matching %s with %s" % [seg_head, cur_seg])
				cur_seg = cur_seg.reverse()
				segs_sorted.insert(0, cur_seg)
				seg_stack.remove_at(s_idx)
				seg_head = cur_seg
				found_seg = true
				break

		if !found_seg:
#			push_warning("loop not continuous")
			break

	#print("segs_sorted %s" % str(segs_sorted))
	
	var result:Loop2D = Loop2D.new()
	result.closed = true
	for s in segs_sorted:
		result.points.append(s.p0)
	
	if seg_head.p0 != seg_tail.p1:
		result.points.append(seg_tail.p1)
		result.closed = false
	
	if face_area_x2_2d(result.points) < 0:
		result.reverse()

	#print("loop %s" % str(result))
		
	return result
	
static func trianglate_face_vertex_indices(points:PackedVector3Array, normal:Vector3)->Array[int]:
	var result:Array[int] = []
	var fv_indices:Array = range(0, points.size())
#	print("trianglate_face_indices %s" % points)
	
	while (points.size() >= 3):
		var num_points:int = points.size()
		var added_point:bool = false

		for i in range(0, num_points):
			var idx0:int = i
			var idx1:int = wrap(i + 1, 0, num_points)
			var idx2:int = wrap(i + 2, 0, num_points)
			var p0:Vector3 = points[idx0]
			var p1:Vector3 = points[idx1]
			var p2:Vector3 = points[idx2]
		
			#Godot uses clockwise winding
			var tri_norm_dir:Vector3 = (p2 - p0).cross(p1 - p0)
			if tri_norm_dir.dot(normal) > 0:
				result.append(fv_indices[idx0])
				result.append(fv_indices[idx1])
				result.append(fv_indices[idx2])
				
#				print("adding indices %s %s %s" % [indices[idx0], indices[idx1], indices[idx2]])
				
				points.remove_at(idx1)
				fv_indices.remove_at(idx1)
				added_point = true
				break
		
		assert(added_point, "failed to add point in triangulation")
#	print("tri_done %s" % str(result))
	
	return result

static func furthest_point_from_line(line_origin:Vector3, line_dir:Vector3, points:PackedVector3Array)->Vector3:
	var best_point:Vector3
	var best_dist:float = 0
	
	for p in points:
		var offset:Vector3 = p - line_origin
		var along:Vector3 = offset.project(line_dir)
		var perp:Vector3 = offset - along
		var dist:float = perp.length_squared()
		if dist > best_dist:
			best_dist = dist
			best_point = p
		
	return best_point

static func furthest_point_from_plane(plane:Plane, points:PackedVector3Array)->Vector3:
	var best_point:Vector3
	var best_distance:float = 0
	
	for p in points:
		var dist = abs(plane.distance_to(p))
		if dist > best_distance:
			best_point = p
			best_distance = dist
			
	return best_point

static func get_convex_hull_points_from_planes(planes:Array[Plane])->Array[Vector3]:
	#Check for overlapping planes
	for i0 in range(0, planes.size()):
		for i1 in range(i0 + 1, planes.size()):
			var p0:Plane = planes[i0]
			var p1:Plane = flip_plane(planes[i1])
			if p0.is_equal_approx(p1):
				return []
	
	var points:Array[Vector3]
	
	for i0 in range(0, planes.size()):
		for i1 in range(i0 + 1, planes.size()):
			for i2 in range(i1 + 1, planes.size()):
				var result = planes[i0].intersect_3(planes[i1], planes[i2])

				if result == null:
					continue
				#print("candidate %s" % result)
				if !planar_volume_contains_point(planes, result):
					continue
				if points.any(func(p):return p.is_equal_approx(result)):
					continue
				#print("adding %s" % result)
				points.append(result)
	
	return points

static func planar_volume_contains_point(planes:Array[Plane], point:Vector3)->bool:
#	print("candidate %s" % point)
	
	for p in planes:
		var is_over:bool = p.is_point_over(point)
		var is_on:bool = p.has_point(point)
		if !is_over && !is_on:
#			print("reject by %s" % p)
			return false
#	print("passed %s" % point)
	return true

static func clip_segment_to_plane_3d(p:Plane, v0:Vector3, v1:Vector3)->PackedVector3Array:
	var clip_v0:bool = !p.is_point_over(v0)
	var clip_v1:bool = !p.is_point_over(v1)
	if clip_v0 && clip_v1:
		return []
	
	if clip_v0:
		v0 = p.intersects_segment(v0, v1)
	elif clip_v1:
		v1 = p.intersects_segment(v0, v1)
	
	return [v0, v1]
	
