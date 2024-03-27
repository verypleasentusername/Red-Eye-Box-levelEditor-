@tool
extends Resource
class_name ConvexBlockData

@export var CurSelected:bool = false
@export var active:bool = false
@export var collsion:bool = true
@export_flags_3d_physics var physics_layer:int
@export_flags_3d_physics var physics_mask:int

@export var vertex_points:PackedVector3Array  #Per vertex
@export var vertex_CurSelected:PackedByteArray  #Per vertex
#@export var vertex_active:PackedByteArray  #Per vertex
@export var active_vertex:int

@export var edge_vertex_indices:PackedInt32Array
@export var edge_CurSelected:PackedByteArray
#@export var edge_active:PackedByteArray
@export var active_edge:int
@export var edge_face_indices:PackedInt32Array

@export var face_vertex_count:PackedInt32Array #Number of verts in each face
@export var face_vertex_indices:PackedInt32Array  #Vertex index per face
@export var face_material_indices:PackedInt32Array #Material index for each face
@export var face_uv_transform:Array[Transform2D]
@export var face_visible:PackedByteArray
@export var face_color:PackedColorArray
@export var face_CurSelected:PackedByteArray  #Per face
#@export var face_active:PackedByteArray  #Per face
@export var active_face:int
@export var face_ids:PackedInt32Array  #Per face

#Validate arrays to make sure they're the right size
func validate_arrays():
	var num_faces:int = face_vertex_count.size()

	if face_visible.size() < num_faces:
		var arr:PackedByteArray
		arr.resize(num_faces - face_visible.size())
		arr.fill(true)
		face_visible.append_array(arr)
		

	if face_color.size() < num_faces:
		var arr:PackedColorArray
		arr.resize(num_faces - face_color.size())
		arr.fill(Color.WHITE)
		face_color.append_array(arr)
		
