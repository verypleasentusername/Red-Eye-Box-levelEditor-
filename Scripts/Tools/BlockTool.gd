extends Node3D

@export var Camera : Camera3D
@export var ViewPortF : SubViewport

@export var GridManager : Node3D

@export var Cursor : Node3D
@export var DebugDirection:Node3D

@export var Blocks : Array[String] = ["Box","Cillinder","Stairs"]

var pointMod = preload("res://Prefabs/Tools/BoxTool/PointModel.tscn")
var CalcPointScript 
var GridY : float 
# vector math
var PointDistance

func _ready():
	CalcPointScript = preload("res://Scripts/Utilities/Static/CalcCursor3D.gd")
	
func _process(_delta):
	Cursor.setCursorPos(CalcPointScript.CalcCursorY(Camera, self,GridManager,ViewPortF))
	DebugDirection.rotation = transform.looking_at(Cursor.position, Vector3.UP).basis.get_euler()
	


