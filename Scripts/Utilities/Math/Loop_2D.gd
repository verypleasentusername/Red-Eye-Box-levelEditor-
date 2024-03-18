@tool
extends Resource
class_name Loop2D

var points:PackedVector2Array
var closed:bool

func reverse():
	points.reverse()
	
func  _to_string():
	return "Loop2D(%s, %s)" % [closed, str(points)]
