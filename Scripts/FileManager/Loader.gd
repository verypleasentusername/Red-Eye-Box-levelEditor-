extends Node

@onready var programm_space = $"../../../UI/UI_actual/MainUI/ProgrammSpace"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var List:ProgrammList = programm_space.add_list("File", 1)
	programm_space.add_command(List, "Новый... +", self.load_map)
	programm_space.add_command(List, "Открыть... +", self.load_map)
	List.update_list()

func load_map():
	var FilePath = "res://SavingData/ReadMe.map"
	var file = FileAccess.open(FilePath,FileAccess.READ)
	var text = file.get_as_text()
	print("File read:")
	print(text)
