extends Node3D
class_name Builder

static func intersect_ray_closest(origin:Vector3, dir:Vector3, BlocksParent:Node3D)->IntersectResults:
	var best_result:IntersectResults
	var blocks:Array[Block] = get_blocks_recursive(BlocksParent)

	for block in blocks:
		if !block.is_visible_in_tree():
			continue
		
		var result:IntersectResults = block.intersect_ray_closest(origin, dir)
#			print("isect %s %s" % [node.name, result])
		if result:
			if !best_result or result.distance_squared < best_result.distance_squared:
#				print("setting best result %s" % node.name)
				best_result = result
#				print("best_result %s" % ray_best_result)
		
#	print("returning best result %s" % ray_best_result)
	return best_result

static func get_blocks_recursive(node:Node)->Array[Block]:
	var result:Array[Block]
	
	if node is Block:
		result.append(node)
	for child in node.get_children():
		result.append_array(get_blocks_recursive(child))
	return result
