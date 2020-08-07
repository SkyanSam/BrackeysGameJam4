extends KinematicBody2D

export (int, 0, 200) var inertia = 100

export var moveSpeed = 300;
export var gravity = 33;
export var maxGravity = 500
export var jumpSpeed = -700.0
export var velocity = Vector2()
var ladder_on = false
var ladder_touching = false
var pushDirection = 0.2;

func _physics_process(delta):
	if Input.is_action_just_pressed("pull"):
		pushDirection = -1
	if Input.is_action_just_released("move_right") and !Input.is_action_pressed("pull"):
		pushDirection = 0.2
	if Input.is_action_just_released("move_left") and !Input.is_action_pressed("pull"):
		pushDirection = 0.2
	if Input.is_action_just_released("pull"):
		if velocity.x == 0:
			pushDirection = 0.2
	
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()
		
	#print(ladder_on)
	rewind_effect()
	if not rewinding:
		if ladder_on:
			velocity.y = 0
			if Input.is_action_pressed("move_up") && ladder_touching:
				velocity.y = -moveSpeed
			elif Input.is_action_pressed("move_down"):
				velocity.y = moveSpeed
			else:
				velocity.y = 0
			
			# So we can push objects without falling
			
				
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
	
	
	
	# after calling move_and_slide()
	for index in get_slide_count():
		
		var collision = get_slide_collision(index)
			
		if collision.collider && not rewinding:
			if collision.collider.is_in_group("bodies"):
				var applyImpulse = true;
				
				#if (pushDirection == -1):
				if abs(collision.normal.y) > 0.05:
						applyImpulse = false;
				
					
				
				print(str(applyImpulse) + "," + str(pushDirection));
				
				if (applyImpulse):
					velocity.y = 0;
					#collision.collider.add_central_force(-collision.normal * inertia * pushDirection);
					collision.collider.apply_central_impulse(Vector2(velocity.x * inertia * pushDirection * delta, 0))
					#collision.collider.apply_central_impulse(-collision.normal * inertia * pushDirection);
			
			elif collision.collider.is_in_group("door"):
				get_node("../../Door").leave()
			
			elif collision.collider.is_in_group("coin"):
				get_node("../../Coins/" + collision.collider.name).free()
				get_node("../../Door").collect_coin()
			
			
	move_and_slide(velocity, Vector2.UP, false, 4, 0.785398, false)
#
var pos = []
var lineal_v = []
var last_v
var recording = true
var rewinding = false

var positionToIntegrate = Vector2.ZERO;
var integrating = false;

	
	

func rewind_effect():
	#if Input.is_action_just_pressed("ui_accept"):
		#sleeping = false
	
	if Input.is_action_just_pressed("rewind"):
		if rewinding:
			_start_recording()
		else:
			_start_rewinding()
	
	if recording:
		pos.append(global_position)
		if pos.size() > 10000:
			pos.remove(0)
			#lineal_v.remove(0)
	if rewinding:
		if pos.size() > 0:
			global_position = pos[pos.size() - 1]
			#last_v = lineal_v[lineal_v.size() - 1]
			pos.remove(pos.size() - 1)
			lineal_v.remove(lineal_v.size() - 1)
		else:
			_start_recording()
			

func _integrate_forces(state):
	if (integrating):
		state.transform.origin = positionToIntegrate
		integrating = false
	
	

func _start_rewinding():
	#mode = RigidBody2D.MODE_KINEMATIC
	recording = false
	rewinding = true

func _start_recording():
	rewinding = false
	recording = true
	integrating = true
	positionToIntegrate = global_position
	#mode = RigidBody2D.MODE_RIGID
			
		
