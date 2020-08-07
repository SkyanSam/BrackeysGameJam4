extends Area2D

export var coinsNeeded = 1;
export var sceneToGoTo = "";
var coinsCollected = 0;

func collect_coin():
	coinsCollected += 1;
	print(coinsCollected)

func leave():
	if (coinsCollected >= coinsNeeded):
		get_tree().change_scene(sceneToGoTo);
	
func _ready():
	add_to_group("door")
	


func _on_Door_body_entered(body):
	if (body.name == "Player"):
		leave()
