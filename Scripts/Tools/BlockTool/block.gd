extends Node3D
class_name Block

var bounds:AABB
var blocks_root_path:NodePath

#initiating a block
func build(mat: Material, shape):
	$Geometry.set_surface_override_material(0,mat)
	$StaticBody3D/CollisionShape3D.set_shape($Geometry.mesh)
	
