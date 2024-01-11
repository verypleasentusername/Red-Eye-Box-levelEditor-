@tool
extends Node3D


@export var Generate:bool :
	get:
		return Generate
	set(gen):
		#Generate=gen
		generate_mesh()
	
@onready var MeshIns =  $MeshInstance3D
var mesh

func generate_mesh():
	
	mesh = BoxMesh.new()
	mesh.size = Vector3(2,5,1)
	MeshIns.mesh = mesh
	print("Mesh generated")

func _ready():
	print(MeshIns)
	generate_mesh()
	
func _input(_event):
	if Input.is_action_just_pressed("ClickFix"):
		mesh.size += Vector3(1,1,1)
