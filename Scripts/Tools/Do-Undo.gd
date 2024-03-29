extends Node3D

#начинается с нуля, но так как 0 это 1 то настоящий 0 будет -1
var CurrentCommand:int = -1

func add_command(command,ComName:String = ""):
	#if we are adding a new command, we delete every next command
	for com in get_children():
		if com.get_index() > CurrentCommand:
			com.queue_free()
	add_child(command)
	command.command_name = ComName+str(CurrentCommand+1)
	command._do_it()
	
	CurrentCommand+=1

func do_command():
	if  get_child_count() > CurrentCommand+1:
		CurrentCommand+=1
		
		var command:Command = get_children()[CurrentCommand]
		command._do_it()

func undo_command():
	if  CurrentCommand != -1:
		var command:Command = get_children()[CurrentCommand]
		command._undo_it()
	
		CurrentCommand-=1

func _input(_event):
	if Input.is_action_just_pressed("_Undo"):
		undo_command()
	if Input.is_action_just_pressed("_Do"):
		do_command()

func get_cur_selected(sel_offset:float = 1) -> Array[NodePath]:
	var best_result:Array[NodePath]
	for i in range(CurrentCommand + sel_offset):
		var Child = get_child(i)
		if Child.is_in_group("CurSelected_nodes"):
			best_result = Child.CurSelected
	return best_result
	
