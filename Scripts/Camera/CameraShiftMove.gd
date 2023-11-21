extends Node

@export var ReferenceNode : Node3D
@export var MoveNode : Node3D
@export var sens : float = 0.025 #a small value


var dirM : Vector2


func _input(event):
	#checking if shifting camera position should be done
	if (event is InputEventMouseMotion) and Input.is_action_pressed("ShiftMove"): 
		
		dirM.x = event.relative.x 
		dirM.y = event.relative.y
		#FIXME: implement

		MoveNode.transform.origin -= ReferenceNode.global_transform.basis.x * dirM.x * sens
		MoveNode.transform.origin -= ReferenceNode.global_transform.basis.y * -dirM.y * sens
		
		#MoveNode.transform.origin -= ReferenceNode.basis.x * sens
		#print(ReferenceNode.global_transform.basis)
		#print(event.relative.y)

