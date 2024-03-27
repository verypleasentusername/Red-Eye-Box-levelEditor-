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
		var dir = TH. Camera.project_ray_normal(event.position)
		var result:IntersectResults = Builder.intersect_ray_closest(TH.Camera.global_position,dir,TH.Map)
		if result:
			command.entity_pos = TH.GridManager.queue_snap(result.get_world_position()+result.get_world_normal()/4)
		else:
			command.entity_pos = TH.GridManager.queue_snap(CalcCursor.CalcCursorXZ(TH.Camera, self, TH.GridManager.global_position,event))
			command.entity_pos.y += 0.25
		command.entity_name = entity_name
		
		TH.do_undo.add_command(command,"entity_")
