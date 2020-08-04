extends Node2D
export var groupName = "";
func _ready():
	for i in get_child_count():
		get_child(i).add_to_group(groupName)
