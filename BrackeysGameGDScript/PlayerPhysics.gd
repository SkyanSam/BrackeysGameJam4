extends KinematicBody2D

export (int, 0, 200) var inertia = 100

export var moveSpeed = 300;
export var gravity = 33;
export var maxGravity = 500
export var jumpSpeed = -700.0
export var velocity = Vector2()
var ladder_on = false
var ladder_touching = false

func _physics_process(delta):
	#print(ladder_on)
			
	if ladder_on:
		velocity.y = 0
		if Input.is_action_pressed("move_up") && ladder_touching:
			velocity.y = -moveSpeed
		elif Input.is_action_pressed("move_down"):
			velocity.y = moveSpeed
		else:
			velocity.y = 0
			
		if Input.is_action_just_pressed("pull"):
			ladder_on = false
			
	else:
		if ladder_touching:
			if Input.is_action_just_pressed("pull"):
				ladder_on = true
			
		velocity.x = (Input.get_action_strength("move_right") - Input.get_action_strength("move_left")) * moveSpeed
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = jumpSpeed;
		else:
			velocity.y += gravity
			velocity.y = clamp(velocity.y, jumpSpeed, maxGravity)
	
	move_and_slide(velocity, Vector2.UP, false, 4, 0.785398, false)
	
	# after calling move_and_slide()
	for index in get_slide_count():
		
		var collision = get_slide_collision(index)
		
		var pushDirection = 1;
		if Input.is_action_pressed("pull"):
			pushDirection = -1
			
		if collision.collider:
			if collision.collider.is_in_group("bodies"):
				var applyImpulse = true;
				
				if (pushDirection == -1):
					if abs(collision.position.y - position.y) > 16:
						applyImpulse = false;
				
				print(str(applyImpulse) + "," + str(pushDirection));
				
				if (applyImpulse):
					collision.collider.apply_central_impulse(-collision.normal * inertia * pushDirection);
			
			elif collision.collider.is_in_group("door"):
				get_node("../Door").leave()
			
			elif collision.collider.is_in_group("coin"):
				get_node("../Coins/" + collision.collider.name).free()
				get_node("../Door").collect_coin()
			
			
		