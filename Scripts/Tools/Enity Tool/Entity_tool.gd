extends Tool

var Point := preload("res://Prefabs/Nodes/Entities/entity_1.tscn")
#узел самой карты, содержит в себе браши, ентити и т.д.
# тупой чтоле блять?
@export var Map: Node3D
@export var Camera:Node3D
@export var GridManager: Node3D


func event_1(event):
	if Input.is_action_just_pressed("Click"):
		var PointIns = Point.instantiate()
		PointIns.set_position(GridManager.queue_snap(CalcCursor.CalcCursorXZ(Camera, self,GridManager.global_position,event)))
		Map.add_child(PointIns)
