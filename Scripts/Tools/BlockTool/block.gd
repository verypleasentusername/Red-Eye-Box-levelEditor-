extends Node3D
class_name Block

var blocks_root_path:NodePath
var control_mesh:ConvexVolume

@onready var mesh_instance: MeshInstance3D = $Geometry
@onready var mesh_wire:MeshInstance3D = $WireMesh
#default
var Mat:Material
var outline_material:Material
#list of
var Materials : Array[Material]

@onready var collision_shape: CollisionShape3D = $StaticBody3D/CollisionShape3D
var block_data : ConvexBlockData:
	get:
		return block_data
	set(value):
		if block_data != value:
			block_data = value
			control_mesh = ConvexVolume.new()
			control_mesh.init_from_convex_block_data(block_data)
	

#initiating a block

func build_from_block():
	#mesh_instance.mesh = null
	#collision_shape.shape = null

	#if Engine.is_editor_hint():
#		var global_scene:CyclopsGlobalScene = get_node("/root/CyclopsAutoload")
		#var global_scene = get_node("/root/CyclopsAutoload")
	
	if !block_data:
		return
	
#	print("got block data")		
	
	var vol:ConvexVolume = ConvexVolume.new()
	vol.init_from_convex_block_data(block_data)
	
	#print("volume %s" % vol)
	
	var mesh:ArrayMesh

	#if Engine.is_editor_hint():
		#var global_scene = get_node("/root/CyclopsAutoload")
	mesh_wire.mesh = vol.create_mesh_wire(outline_material)
		#print ("added wireframe")

		#print ("added faces")
	#else:
	##FIXME [Mat] поменять на Materials[]
	mesh = vol.create_mesh([Mat], Mat)
	
	mesh_instance.mesh = mesh
	
	var shape:ConvexPolygonShape3D = ConvexPolygonShape3D.new()
	shape.points = vol.get_points()
	collision_shape.shape = shape
	
	#if !Engine.is_editor_hint():
		##Disabling this in the editor for now since this is causing slowdown
		#var occluder_object:ArrayOccluder3D = ArrayOccluder3D.new()
		#occluder_object.vertices = vol.get_points()
		#occluder_object.indices = vol.get_trimesh_indices()
		#occluder.occluder = occluder_object
	
func intersect_ray_closest(origin:Vector3, dir:Vector3)->IntersectResults:
	if !block_data:
		return null
	
	var xform:Transform3D = global_transform.affine_inverse()
	var origin_local:Vector3 = xform * origin
	var dir_local:Vector3 = xform.basis * dir
	
	var result:IntersectResults = control_mesh.intersect_ray_closest(origin_local, dir_local)
	if result:
		result.object = self
		
	return result
