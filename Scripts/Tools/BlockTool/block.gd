extends Node3D

#initiating a block
func build(mat: Material):
	$Geometry.set_surface_override_material(0,mat)
	$StaticBody3D/CollisionShape3D.set_shape($Geometry.mesh)
	
