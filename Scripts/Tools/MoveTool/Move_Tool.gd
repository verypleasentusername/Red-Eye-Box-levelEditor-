extends Tool

#ToolHolder
@export var TH:Node3D
#FIXME ахахах никогда блять!
#Буфер. дикий костыль, вообще пиздец
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
	#select is only applied when click is ended
	if Input.is_action_just_released("Click"):
		#если движения не было, то это команда на выбор объектов, если движение было, то это 
		#команда на отчёт о действии
		if (Cpos == Cstart_pos):
			var dir =TH. Camera.project_ray_normal(event.position)
			var result:IntersectResults = Builder.intersect_ray_closest(TH.Camera.global_position,dir,TH.Map)
			if result:
				if Input.is_action_pressed("Shift"):
					TH.Map.SelectedNodes.append(result.object)
				else:
					TH.Map.SelectedNodes.clear()
					TH.Map.SelectedNodes.append(result.object)
				$Directions.global_position = TH.Map.get_select_position()
		else:
			var command:CommandMove = CommandMove.new()
			command.command_name = GeneralUtil.find_unique_name(TH.do_undo,"move_")
			command.start_pos = TH.Map.get_selected_start_position()
			command.ObjToMove = TH.Map.StartSelected
			command.move = Cpos-Cstart_pos
			TH.do_undo.add_command(command)
	#click start is a prep for click HOLD
	if Input.is_action_just_pressed("Click"):
		start_camera = TH.Camera
		start_event = event
		if  TH.Map.if_select_exists():
			TH.Map.set_start_pos()
	#HOLD
	if Input.is_action_pressed("Click"):
			Cstart_pos = get_typed_movement(start_event, start_camera)
			Cpos = get_typed_movement(event, TH.Camera)
			if  TH.Map.if_select_exists():
				move(position,event)
				$Directions.global_position = TH.Map.get_select_position()


func move(position:Vector3,event):
	TH.Map.move_selected(Cpos-Cstart_pos)
	print(str(Cpos)+"ongoing")
	print(str(Cstart_pos)+"start")

func get_typed_movement(event, Camera):
	if Input.is_action_pressed("Shift"):
		move_dir=MOVE_DIRS.Y
		$Directions/DirY.visible = true
		$Directions/DirX.visible = false
		$Directions/DirZ.visible = false
		return TH.GridManager.queue_snap(CalcCursor.CalcCursorY(Camera, TH.Map.get_select_position(), event))
	else:
		move_dir=MOVE_DIRS.XZ
		$Directions/DirY.visible = false
		$Directions/DirX.visible = true
		$Directions/DirZ.visible = true
		return TH.GridManager.queue_snap(CalcCursor.CalcCursorXZ(Camera,self,TH.Map.get_select_position(), event))

