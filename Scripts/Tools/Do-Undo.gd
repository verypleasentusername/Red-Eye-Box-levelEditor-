extends Node3D

var CurrentCommand:int = 0

func add_command(command):
	add_child(command)
	CurrentCommand+=1
	

func undo_command():
	get_children()[CurrentCommand].queue_free()
	CurrentCommand-=1
