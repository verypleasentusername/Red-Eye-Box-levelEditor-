extends Control
class_name ProgrammList

@export var ButtonParent: VBoxContainer
var button:= preload("res://Prefabs/UI/menu_button.tscn") 

var my_list: ProgrammList

func update_list():
	for i in range(my_list.options_names.size()):
		var button_ins = button.instantiate()
		button_ins.name = my_list.options_names[i]
		button_ins.pressed.connect(my_list.options_funcs)
		ButtonParent.add_child(button_ins)
