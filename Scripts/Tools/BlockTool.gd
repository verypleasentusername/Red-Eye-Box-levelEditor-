extends Node3D

@export var Camera : Camera3D
@export var ViewPortF : SubViewport

@export var GridManager : Node3D

@export var Blocks : Array[String] = ["Box","Cillinder","Stairs"]

var CalcPointScript  

@export var Cursor : Node3D
@export var DebugDirection:Node3D
# база 2 потому что первая задаётся на ready
enum TOOL_STATES {BASE1,BASE2,HIGH}
var tool_state = TOOL_STATES.BASE1
var block_cursor:Vector3
var block_p0:Vector3
var block_p1:Vector3
var block_p2:Vector3


func _ready():
	CalcPointScript = preload("res://Scripts/Utilities/Static/CalcCursor3D.gd")
	
func _process(_delta):
	#make sure that cursor is following right ways
	if tool_state == TOOL_STATES.BASE1:
		Cursor.setCursorPos(CalcPointScript.CalcCursorXZ(Camera, self,GridManager,ViewPortF))
		#DebugDirection.rotation = transform.looking_at(Cursor.position, Vector3.UP).basis.get_euler()
	elif tool_state == TOOL_STATES.BASE2:
		Cursor.setCursorPos(CalcPointScript.CalcCursorXZ(Camera, self,GridManager,ViewPortF))
	elif tool_state == TOOL_STATES.HIGH:
		Cursor.setCursorPos(CalcPointScript.CalcCursorY(Camera, block_p1, GridManager,ViewPortF))
		
	block_cursor = Cursor.transform.origin
	
func _input(event):
	print(event)
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
			BuildBlock()
			tool_state = TOOL_STATES.BASE1

func BuildBlock():
	print("Here we buildin'!")
