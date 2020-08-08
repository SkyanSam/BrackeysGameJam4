extends AnimatedSprite

func _ready():
	pass # Replace with function body.

func _process(delta):
	if (Input.get_action_strength("move_left")):
		flip_h = false
	elif (Input.get_action_strength("move_right")):
		flip_h = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
