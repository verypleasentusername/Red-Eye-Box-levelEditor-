extends Node

var GridY : float = 0
@export var GridInterval := 0.5
#placeholder grid point
var GridPoint = preload("res://Prefabs/Grid/grid_p_oint.tscn")

@onready var GridLabel = $"../../UI/UI_actual/All of UI/WorkSpace/MapTools/HBoxContainer/Label"
@onready var GridParent = $"./GridHolder"


func _ready() -> void:
	GenerateGrid()

#FIXME: you do not spawn a grid of cubes as a grid. its retarded.
func GenerateGrid():
	#remove Children in case of re-generation
	for n in GridParent.get_children():
		GridParent.remove_child(n)
		n.queue_free()
	GridY = GridParent.position.y
	for x in range(-5/GridInterval, (5/GridInterval)+1):
		for z in range(-5/GridInterval, (5/GridInterval)+1):
			var GridIns = GridPoint.instantiate()
			GridIns.set_position(Vector3((x*GridInterval),0,(z*GridInterval)))
			GridParent.add_child(GridIns)
	GridLabel.text = str(GridInterval)
	print("Grid Generation Seccesfull")
	
func SnapTo(Position):
	return roundTo(Position,GridInterval)
	
func roundTo(n, to):
	return round(n/to) * to
	

func _on_grid_plus_button_pressed():
	GridInterval *= 2
	GenerateGrid()

func _on_grid_minus_button_pressed():
	GridInterval /= 2
	GenerateGrid()
