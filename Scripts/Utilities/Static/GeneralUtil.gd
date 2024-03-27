@tool
class_name GeneralUtil

static func find_unique_name(parent:Node, base_name:String)->String:
	#Check if numeric suffix already exists
	#var regex = RegEx.new()
	#regex.compile("(\\d+)")
	#var match_res:RegExMatch = regex.search(base_name)
	
	var name_idx:int = 0
	
	#if match_res:
	#	var suffix:String = match_res.get_string(1)
	#	name_idx = int(suffix) + 1
	#	base_name = base_name.substr(0, base_name.length() - suffix.length())

	#Search for free index	
	while true:
		var name = base_name + str(name_idx)
		if !parent.find_child(name, false):
			return name
			
		name_idx += 1
		
	return ""
