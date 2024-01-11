extends Node


var GridY : float = 0
#placeholder grid point
var GridPoint = preload("res://Prefabs/Grid/grid_p_oint.tscn")
@onready var GridParent = $"./GridHolder"

func _ready() -> void:
	for x in range(-5,5):
		for z in range(-5,5):
			var GridIns = GridPoint.instantiate()
			GridIns.set_position(Vector3(x,0,z))
			GridParent.add_child(GridIns)
	print("Grid Generation Seccesfull")
	
