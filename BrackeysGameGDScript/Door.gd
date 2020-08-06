extends StaticBody2D

export var coinsNeeded = 1;
export var sceneToGoTo = "";
var coinsCollected = 0;

func collect_coin():
	coinsCollected += 1;

func leave():
	if (coinsCollected >= coinsNeeded):
		get_tree().change_scene(sceneToGoTo);
	
func _ready():
	add_to_group("door")
	
