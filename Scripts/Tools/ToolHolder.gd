extends Node3D

@export var ToolList: Array[Node]
var current_tool = 0


func _on_move_tool_pressed():
	current_tool = 0
	DisableAll()
	ToolList[0].process_mode = Node.PROCESS_MODE_INHERIT
	ToolList[0].visible = true
	print("Move Tool Selected")

func _on_box_tool_pressed():
	current_tool = 1
	DisableAll()
	ToolList[1].process_mode = Node.PROCESS_MODE_INHERIT
	ToolList[1].visible = true
	print("Box Tool Selected")

func ToolEvent_1():
	pass

func DisableAll():
	for node in ToolList:
		node.process_mode = Node.PROCESS_MODE_DISABLED
		node.visible = false
