extends Command
class_name CommandMove

var move: Vector3
var start_pos: Array[Vector3]
var ObjToMove: Array[NodePath]

func _do_it():
	name = command_name
	for i in range(ObjToMove.size()):
		get_node(ObjToMove[i]).global_position = start_pos[i] + move
	print(command_name + " done")
	
func _undo_it():
	for i in range(ObjToMove.size()):
		get_node(ObjToMove[i]).global_position = start_pos[i]
	print(command_name + " undone")
