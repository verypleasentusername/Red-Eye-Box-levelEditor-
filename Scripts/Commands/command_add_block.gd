extends Command
class_name CommandAddBlock

var block_root_path : NodePath
var bounds:AABB
var uv_transform : Transform2D = Transform2D.IDENTITY
var Mat:Material

var block_path:NodePath
#взято с 
# https://github.com/blackears/cyclopsLevelBuilder/blob/6ff5fce2d77ed65b8bcbe747da2f857fe9eb9a1a/godot/addons/cyclops_level_builder/commands/cmd_add_block.gd
func _do_it():
	var block:Block = preload("res://Prefabs/Nodes/Blocks/block.tscn").instantiate()
	block.name = command_name
	name = command_name
	
	var block_parent = get_node(block_root_path)
	block_parent.add_child(block)
	
	var mesh:ConvexVolume = ConvexVolume.new()
	mesh.init_block(bounds, uv_transform)
	print(block.position)
	mesh.translate(-bounds.position)
	
	block.Mat = Mat
	block.block_data = mesh.to_convex_block_data()
	block_path = block.get_path()
	block.global_transform = Transform3D(Basis(), bounds.position)
	
	block.build_from_block()
	print( command_name + " done")
	
func _undo_it():
	var block:Block = get_node(block_path)
	block.queue_free()
	print(command_name + " undone")

