extends Control
class_name ProgrammSpace

var list_node = preload("res://Prefabs/UI/pop_up_features.tscn")

func add_list(ListName: String, _position:int):
	var p_list = ListData.new()
	var list_ins = list_node.instantiate()
	list_ins.name = ListName
	add_child(list_ins)
	list_ins.my_list = p_list
	return list_ins

static func add_command(list_ins: ProgrammList, option_name:String, option_func:String):
	list_ins.my_list.options_names.append(option_name)
	list_ins.my_list.options_funcs.append(option_func)

