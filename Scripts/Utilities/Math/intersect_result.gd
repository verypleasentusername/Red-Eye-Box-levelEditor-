@tool
extends RefCounted
class_name IntersectResults

#FIXME:change for brush type node
var object:Node3D
var face_id:int
var face_index:int
var position:Vector3 #local space of block
var normal:Vector3
var distance_squared:float

func get_world_position()->Vector3:
	return object.global_transform * position

func get_world_normal()->Vector3:
	var basis:Basis = object.global_transform.basis
	var basis_normals:Basis = basis.inverse().transposed()
	return basis_normals * normal

func _to_string():
	return "object:%s face_id:%s pos:%s norm:%s dist_sq:%s" % [object, face_id, position, normal, distance_squared]
