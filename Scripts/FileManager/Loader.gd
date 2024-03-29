extends Node

@onready var programm_space = $"../../../UI/UI_actual/MainUI/ProgrammSpace"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var FilePath = "res://SavingData/ReadMe.map"
	var file = FileAccess.open(FilePath,FileAccess.READ)
	var text = file.get_as_text()
	print(text)
	
	programm_space.add_list("File", 1)
