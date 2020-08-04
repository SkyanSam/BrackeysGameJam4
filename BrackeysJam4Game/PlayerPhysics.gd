extends KinematicBody2D

var player = load("res://Player.cs")
export (int, 0, 200) var inertia = 100

func _physics_process(delta):
	# after calling move_and_slide()
	for index in get_slide_count():
		
		var collision = get_slide_collision(index)
		
		var pushDirection = 1;
		if Input.is_action_pressed("pull"):
			pushDirection = -1
		
		if collision.collider.is_in_group("bodies"):
			collision.collider.apply_central_impulse(-collision.normal * inertia * pushDirection)
