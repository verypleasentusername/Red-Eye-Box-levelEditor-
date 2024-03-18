extends Node3D

#начинается с нуля, но так как 0 это 1 то настоящий 0 будет -1
var CurrentCommand:int = -1

func add_command(command):
	add_child(command)
	command._do_it()
	
	CurrentCommand+=1
	print("command added")

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

func _input(event):
	if Input.is_action_just_pressed("_Undo"):
		undo_command()
	if Input.is_action_just_pressed("_Do"):
		do_command()
