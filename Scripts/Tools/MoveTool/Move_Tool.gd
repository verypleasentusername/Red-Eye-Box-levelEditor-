extends Tool

#ToolHolder
@export var TH:Node3D
#FIXME Буфер. дикий костыль, вообще пиздец
#ахахах никогда блять!
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
	if event.is_action("Click") and Input.is_action_just_released("Click"):
		print("released")
		#SELECT command
		if (Cpos == Cstart_pos):
			var dir =TH. Camera.project_ray_normal(event.position)
			var result:IntersectResults = Builder.intersect_ray_closest(TH.Camera.global_position,dir,TH.Map)
			
			var command_sel:CommandSelect = CommandSelect.new()
			if result:
				command_sel.cur_sel = result.object
				$Directions.global_position = TH.Map.get_select_position()#FIXME Change to proper Directions movement func
			if !Input.is_action_pressed("Shift"):
				command_sel.addition = false
				
			command_sel.add_to_group("CurSelected_nodes")
			command_sel.DoUndo = TH.do_undo
			TH.do_undo.add_command(command_sel,"select_")
				
		#if we dragged somewhere before release, commit MOVE command
		elif TH.Map.if_select_exists():
			var command:CommandMove = CommandMove.new()
			command.start_pos.assign(TH.Map.get_cur_selected_start_position())
			command.ObjToMove.assign(TH.do_undo.get_cur_selected())
			command.move = Cpos-Cstart_pos
			TH.do_undo.add_command(command,"move_")
			
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
				move()
				$Directions.global_position = TH.Map.get_select_position()


func move():
	TH.Map.move_cur_selected(Cpos-Cstart_pos)

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

