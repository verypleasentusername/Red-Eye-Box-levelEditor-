extends Command
class_name CommandAddEntity

#public
var entity_root_path:NodePath
var entity_name:String
var entity_pos:Vector3  

#private
var entity_path:NodePath

func _do_it():
	var entity:Entity = preload("res://Prefabs/Nodes/Entities/entity.tscn").instantiate()
	entity.name = command_name
	name = command_name
	
	var entity_parent = get_node(entity_root_path)
	entity_parent.add_child(entity)
	
	entity.global_position = entity_pos
	entity_path = entity.get_path()
	print(command_name + " done")
	
func _undo_it():
	var entity:Entity = get_node(entity_path)
	entity.queue_free()
	print(command_name + " undone")
