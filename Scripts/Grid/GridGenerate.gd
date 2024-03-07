extends Node

var GridY : float = 0
@export var GridSizeW:=10

@export var GridInterval := 0.5
@export var GridSnap := false
#placeholder grid point
var GridPoint = preload("res://Prefabs/Grid/grid_p_oint.tscn")

@onready var GridLabel = $"../../UI/UI_actual/All of UI/WorkSpace/MapTools/HBoxContainer/Label"
@onready var GridSnapCB = $"../../UI/UI_actual/All of UI/WorkSpace/MapTools/HBoxContainer/CheckBox"

@onready var GridParent = $"./GridHolder"
@export var GridMesh : MultiMeshInstance3D


func _ready() -> void:
	GenerateGrid()
	GridSnapCB.button_pressed = GridSnap

#FIXME: you do not spawn a grid of cubes as a grid. its retarded.
func GenerateGrid():
	#remove Children in case of re-generation
	#for n in GridParent.get_children():
	#	GridParent.remove_child(n)
	#	n.queue_free()
	GridY = GridParent.position.y
	GridMesh.multimesh.instance_count = (2*(GridSizeW/GridInterval+1) * 2*(GridSizeW/GridInterval+1))
	var CurrentIns = 0
	for x in range(-GridSizeW/GridInterval, (GridSizeW/GridInterval)+1):
		for z in range(-GridSizeW/GridInterval, (GridSizeW/GridInterval)+1):
			GridMesh.multimesh.set_instance_transform(CurrentIns, Transform3D(Basis(), Vector3(x*GridInterval, 0.0, z*GridInterval)))
			CurrentIns += 1
			#var GridIns = GridPoint.instantiate()
			#GridIns.set_position(Vector3((x*GridInterval),0,(z*GridInterval)))
			#GridParent.add_child(GridIns)
			print(CurrentIns)
	GridLabel.text = str(GridInterval)
	print("Grid Generation Seccesfull")
	
	
func QueSnap(Position):
	if GridSnap == true:
		return roundTo(Position,GridInterval)
	else:
		return Position
		
func roundTo(n, to):
	return round(n/to) * to
	

func _on_grid_plus_button_pressed():
	GridInterval *= 2
	GenerateGrid()

func _on_grid_minus_button_pressed():
	GridInterval /= 2
	GenerateGrid()

func _on_check_box_toggled(toggled_on):
	GridSnap = toggled_on
