extends Command
class_name CommandSelect

var DoUndo:Node3D
#Current object To this command
var cur_sel:Node3D
var addition:= true
#private
var CurSelected:Array [NodePath]
const BlockClass = preload("res://Scripts/Tools/BlockTool/block.gd") #FIXME proper 

func _ready():
	CurSelected.assign(DoUndo.get_cur_selected())
	if !addition:
		deselect()
		CurSelected.clear()
	if cur_sel != null:
		CurSelected.append(cur_sel.get_path())
		select()
	else:
		deselect()

func _do_it():
	name = command_name
	for i in DoUndo.get_cur_selected(0):
		get_node(i).upd_wire(false)
	select()

func _undo_it():
	for i in DoUndo.get_cur_selected(0):
		get_node(i).upd_wire(true)
	deselect()
	
func deselect():
	for path in CurSelected:
		if get_node(path) is BlockClass:
			get_node(path).upd_wire(false)
			
func select():
	deselect()
	for path in CurSelected:
		if get_node(path) is BlockClass:
			get_node(path).upd_wire(true)
