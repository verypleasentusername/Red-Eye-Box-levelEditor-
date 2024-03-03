extends MeshInstance3D

@export var  Snapping := true

@onready var GridGenerate:= $"../../../GridManager"


# Called when the node enters the scene tree for the first time.
func setCursorPos(Position):
	if Snapping:
		Position = GridGenerate.SnapTo(Position)
	global_position = Position


