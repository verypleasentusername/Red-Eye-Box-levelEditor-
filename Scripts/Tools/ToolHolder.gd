extends Node3D
#shared tools info
@export var Camera:Camera3D

@export var Map:Node3D
@export var Brushes:Node3D
@export var Entities:Node3D

@export var GridManager:Node3D
@export var do_undo:Node3D

@export var ToolList: Array[Node]
var current_tool = 0

func _ready():
	_on_box_tool_pressed()

func _on_box_tool_pressed():
	current_tool = 0
	DisableAll()
	ToolList[0]._activate()
	ToolList[0].process_mode = Node.PROCESS_MODE_INHERIT
	ToolList[0].visible = true
	print("Box Tool Selected")

func _on_move_tool_pressed():
	current_tool = 1
	DisableAll()
	ToolList[1]._activate()
	ToolList[1].process_mode = Node.PROCESS_MODE_INHERIT
	ToolList[1].visible = true
	print("Move Tool Selected")
	
func _on_obj_tool_pressed():
	current_tool = 2
	DisableAll()
	ToolList[2]._activate()
	ToolList[2].process_mode = Node.PROCESS_MODE_INHERIT
	ToolList[2].visible = true
	print("Obj Tool Selected")

func DisableAll():
	for node in ToolList:
		node._deactivate()
		node.process_mode = Node.PROCESS_MODE_DISABLED
		node.visible = false


func _on_viewport_container_main_gui_input(event):
	ToolList[current_tool].event_1(event)

