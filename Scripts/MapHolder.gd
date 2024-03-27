extends Node3D
class_name MapHolder

#FIXME пиздец а не решение
# должно быть типа Node3D но поскольку блоки удаляются, то запоминать их легче как нод паф
@export var DoUndo:Node3D
#private
var start_pos:Array [Vector3]

func get_select_position():
	if if_select_exists():
		return get_node(DoUndo.get_cur_selected()[0]).position
	else:
		return Vector3.ZERO

func get_cur_selected_start_position():
	return start_pos

func get_cur_selected_position():
	var pos:Array[Vector3] 
	for i in range(DoUndo.get_cur_selected().size()):
		pos.append(get_node(DoUndo.get_cur_selected()).global_position)
	return pos

func set_start_pos():
	update_current_mov()
	for i in range(DoUndo.get_cur_selected().size()):
		start_pos[i] = get_node(DoUndo.get_cur_selected()[i]).global_position
func update_current_mov():
	start_pos.resize(DoUndo.get_cur_selected().size())


func move_cur_selected(pos:Vector3):
	var CurSelected = DoUndo.get_cur_selected()
	for i in range(CurSelected.size()):
		get_node(CurSelected[i]).global_position = pos+start_pos[i]

func if_select_exists():
	var CurSelected = DoUndo.get_cur_selected()
	if CurSelected.size() > 0:
		for i in range(CurSelected.size()):
			if get_node(CurSelected[i]) != null:
				return true
	else:
		return false
