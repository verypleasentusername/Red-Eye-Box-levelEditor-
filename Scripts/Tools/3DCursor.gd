extends MeshInstance3D

@export var  Snapping := true

@onready var GridGenerate:= $"../../../GridManager"


# Called when the node enters the scene tree for the first time.
func setCursorPos(Position):
	Position = GridGenerate.QueSnap(Position)
	global_position = Position


