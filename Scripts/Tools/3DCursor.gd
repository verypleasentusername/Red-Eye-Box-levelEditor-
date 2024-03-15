extends MeshInstance3D

@export var  Snapping := true

@export var GridGenerate: Node3D


# Called when the node enters the scene tree for the first time.
func setCursorPos(Position):
	Position = GridGenerate.queue_snap(Position)
	global_position = Position
	$Label3D.text = str(position)


