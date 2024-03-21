extends Node3D
class_name MapHolder

var SelectedNodes:Array [Node3D]
var StartSelected:Array [Node3D]

#private
var start_pos:Array [Vector3]

func get_select_position():
	if if_select_exists():
		return SelectedNodes[0].position
	else:
		return Vector3.ZERO

func get_selected_start_position():
	return start_pos

func get_selected_position():
	var pos:Array[Vector3] 
	for i in range(SelectedNodes.size()):
		pos.append(SelectedNodes[i].global_position)
	return pos

func set_start_pos():
	update_start_pos()
	for i in range(SelectedNodes.size()):
		start_pos[i] = SelectedNodes[i].global_position
func update_start_pos():
	start_pos.resize(SelectedNodes.size())

func move_selected(move:Vector3):
	StartSelected.clear()
	for i in range(SelectedNodes.size()):
		SelectedNodes[i].position = move + start_pos[i]
		StartSelected.append(SelectedNodes[i])

func if_select_exists():
	if SelectedNodes.size() > 0:
		return true
	else:
		return false

