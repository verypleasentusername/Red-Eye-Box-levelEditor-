extends Node3D

@export var DoUndo: Node3D

func _ready():
	hide_all()
	
func mov_XZ():
	hide_all()
	$DirX.visible = true
	$DirZ.visible = true
	print("xz")
	
func mov_Y():
	hide_all()
	$DirY.visible = true
	print("y")
	
func hide_all():
	$DirX.visible = false
	$DirY.visible = false
	$DirZ.visible = false
	
func upd_mov(position: Vector3):
	transform.origin = position

func upd_vis():
	if DoUndo.get_cur_selected().size() == 0:
		hide_all()
