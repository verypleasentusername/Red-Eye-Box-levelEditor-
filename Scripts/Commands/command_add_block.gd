extends Command
class_name CommandAddBlock

var block_root_path:NodePath
var block_name:String
var bounds:AABB
var uv_transform : Transform2D = Transform2D.IDENTITY

var block_path:NodePath

func do_it():
	var block:Block = preload("res://Scripts/Tools/BlockTool/block.gd").new()
	var block_parent:Node = get_node(block_root_path)
	block_parent.add_child(block)
	var mesh:ConvexVolume = ConvexVolume.new()
	
func undo_it():
	var block:Block = get_node(block_path)
	block.queue_free()

