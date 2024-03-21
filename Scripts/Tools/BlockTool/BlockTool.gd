extends Tool

@export var Camera : Camera3D
@export var ViewPortF : SubViewport

@export var TH : Node3D

enum  BLOCK_TYPES {Box,Cillinder,Stairs}
var BlockType = BLOCK_TYPES.Box

@export var Cursor : Node3D
@export var Drawer: Node3D
# база 2 потому что первая задаётся на ready
enum TOOL_STATES {BASE1,BASE2,HIGH}
var tool_state = TOOL_STATES.BASE1
var block_cursor:Vector3
var block_p0:Vector3
var block_p1:Vector3
var block_p2:Vector3
var block:= preload("res://Prefabs/Nodes/Blocks/block.tscn")
#public settings
#---#
@export var Mat:Material
	
func update_cursor(event):
	Drawer.clear_tool_mesh()
	#make sure that cursor is following right ways
	if tool_state == TOOL_STATES.BASE1:
		var dir = Camera.project_ray_normal(event.position)
		var result:IntersectResults = Builder.intersect_ray_closest(Camera.global_position,dir,TH.Map)
		if result:
			Cursor.setCursorPos(result.get_world_position())
		else:
			Cursor.setCursorPos(CalcCursor.CalcCursorXZ(Camera, self,TH.GridManager.global_position,event))
	elif tool_state == TOOL_STATES.BASE2:
		var p01 = block_cursor
		var p10 = block_p0
		p01.x = block_p0.x
		p10.x = block_cursor.x
		var base_points = [block_p0,p01,block_cursor,p10]
		Drawer.draw_loop(base_points,true)
		Cursor.setCursorPos(CalcCursor.CalcCursorXZ(Camera, self,block_p0,event))
	elif tool_state == TOOL_STATES.HIGH:
		Drawer.draw_cube(block_p0, block_p1, block_cursor)
		Cursor.setCursorPos(CalcCursor.CalcCursorY(Camera, block_p1, event))
		
	block_cursor = Cursor.transform.origin
	
#--INHERITED--#
func event_1(event):
	update_cursor(event)
	#первую точку мы задаём всегда, т.к. интструмент в режиме готовности
	if tool_state == TOOL_STATES.BASE1:
		block_p0 = block_cursor
		
	if Input.is_action_just_pressed("Click"):
		if tool_state ==TOOL_STATES.BASE1:
			print("point one set")
			tool_state = TOOL_STATES.BASE2
			
		elif tool_state == TOOL_STATES.BASE2:
			block_p1 = block_cursor
			print("point two set")
			tool_state = TOOL_STATES.HIGH
			
		elif tool_state == TOOL_STATES.HIGH:
			block_p2 = block_cursor
			print("point three set!")
			build_block()
			tool_state = TOOL_STATES.BASE1
	#cancel any building sets and just get back to first step
	if Input.is_action_just_pressed("RightClick"):
		tool_state = TOOL_STATES.BASE1

func _deactivate():
	tool_state = TOOL_STATES.BASE1

#
func build_block():
	#TODO почистить наверное? хуй знает заебало
	var bounds:AABB = AABB(block_p0, Vector3.ZERO)
	bounds = bounds.expand(block_p1)
	bounds = bounds.expand(block_p2)
	if bounds.has_volume():
		
		var command:CommandAddBlock = CommandAddBlock.new()
		
		var Command_name: String =  GeneralUtil.find_unique_name(TH.Brushes, "block_")
		command.command_name = Command_name
		command.bounds = bounds
		command.block_root_path = TH.Brushes.get_path()
		command.Mat = Mat
		
		TH.do_undo.add_command(command)

