extends Node3D

var tool_mesh: ImmediateMesh
@export var matE: Material

func _ready():
	tool_mesh = ImmediateMesh.new()
	$DrawerInstance3D.mesh = tool_mesh

func draw_loop(points:PackedVector3Array, closed:bool = true, mat:Material = matE):
	if points.is_empty():
		return
	tool_mesh.surface_begin(Mesh.PRIMITIVE_LINE_STRIP, mat)
	for p in points:
		tool_mesh.surface_add_vertex(p)
	if closed:		
		tool_mesh.surface_add_vertex(points[0])
	tool_mesh.surface_end()
# :3
func draw_cube(p0:Vector3, p1:Vector3, p2:Vector3):
	var p10 = p0
	var p01 = p1
	p10.x = p1.x
	p01.x = p0.x
	draw_loop([p0,p10,p1,p01],true)
	draw_pillars([p0,p01,p1,p10],p2.y)
	p0.y = p2.y
	p01.y = p2.y
	p1.y = p2.y
	p10.y = p2.y
	draw_loop([p0,p10,p1,p01],true)
	
func draw_pillars(points:PackedVector3Array, height:float):
	if points.is_empty():
		return
	for p in points:
		tool_mesh.surface_begin(Mesh.PRIMITIVE_LINE_STRIP, matE)
		tool_mesh.surface_add_vertex(p)
		p.y += height
		tool_mesh.surface_add_vertex(p)
		tool_mesh.surface_end()


func clear_tool_mesh():
	#tool_mesh = ImmediateMesh.new()
	#$ToolInstance3D.mesh = tool_mesh
	tool_mesh.clear_surfaces()
