extends Node3D

@export var DoUndo: Node3D

func _ready():
	hide_all()
	
func mov_XZ():
	hide_all()
	$DirX.visible = true
	$DirZ.visible = true
	
func mov_Y():
	hide_all()
	$DirY.visible = true
	
func hide_all():
	$DirX.visible = false
	$DirY.visible = false
	$DirZ.visible = false
	
func upd_mov(position: Vector3):
	if DoUndo.get_cur_selected().size() == 0:
		hide_all()
	transform.origin = position

