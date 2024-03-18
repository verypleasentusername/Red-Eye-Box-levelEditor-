extends Tool

#ToolHolder
@export var TH:Node3D
#FIXME ахахах никогда блять!
#Буфер. дикий костыль, вообще пиздец
var SelectedNode:Node3D
var start_camera:Camera3D
var start_event: InputEvent

var start_pos:Vector3
var Cstart_pos:Vector3 
var Cpos:Vector3


#settings
enum TYPE_SELECTION{ OBJ, FACE, EDGE, VERTEX}
enum MOVE_DIRS{XZ,Y,VIEWPLANE}
var move_dir = MOVE_DIRS.XZ

func event_1(event):
	var Map = TH.Map
	#CLICK
	if Input.is_action_just_pressed("Click"):
		SelectedNode = Map.get_children()[randi()%Map.get_child_count()]
		start_pos = SelectedNode.global_position
		start_camera = TH.Camera
		start_event = event
	#HOLD
	if Input.is_action_pressed("Click") and SelectedNode != null:
			move(position,event)
			$Directions.global_position = SelectedNode.global_position


func move(position:Vector3,event):
	Cstart_pos = get_typed_movement(start_event,start_camera)
	Cpos = get_typed_movement(event)
	SelectedNode.global_position = (Cpos-Cstart_pos)+start_pos

func get_typed_movement(event, Camera=null):
	var CameraLocal: Node3D
	if Camera==null:
		CameraLocal = TH.Camera
	else:
		CameraLocal = Camera
	if Input.is_action_pressed("Shift"):
		return TH.GridManager.queue_snap(CalcCursor.CalcCursorY(CameraLocal,SelectedNode.global_position,event))
		move_dir=MOVE_DIRS.Y
	else:
		return TH.GridManager.queue_snap(CalcCursor.CalcCursorXZ(CameraLocal,self,start_pos,event))
		move_dir=MOVE_DIRS.XZ
