extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var firstTimeTouchingLadder = true;
export var minX = 0;
export var maxX = 1920;
var velocity = Vector2.ZERO;
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body

func _process(delta):
	if position.x > maxX:
		velocity = Vector2.ZERO
	position += velocity * delta;
	
func _physics_process(delta):
	pass

func _on_Ladder_body_entered(body):
	if (body.name == "Player"):
		get_node("../PlayerScene/Player").ladder_touching = true;
		if (firstTimeTouchingLadder):
			firstTimeTouchingLadder = false;
			velocity.x = 400;


func _on_Ladder_body_exited(body):
	if (body.name == "Player"):
		get_node("../PlayerScene/Player").ladder_touching = false;
