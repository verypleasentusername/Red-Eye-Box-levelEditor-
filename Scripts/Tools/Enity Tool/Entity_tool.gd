extends Tool
#узел самой карты, содержит в себе браши, ентити и т.д.
# тупой чтоле блять?
@export var TH: Node3D
#Tool info
@export var entity_name: String

func event_1(event):
	if Input.is_action_just_pressed("Click"):
		
		var command:CommandAddEntity = CommandAddEntity.new()
		
		command.entity_root_path = TH.Entities.get_path()
		command.entity_pos = TH.GridManager.queue_snap(CalcCursor.CalcCursorXZ(TH.Camera, self, TH.GridManager.global_position,event))
		command.command_name = GeneralUtil.find_unique_name(TH.Entities,"entity_")
		command.entity_name = entity_name
		
		TH.do_undo.add_command(command)
