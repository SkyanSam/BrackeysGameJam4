extends RigidBody2D

export var isRotationLocked = true;
var pos = []
var lineal_v = []
var last_v
var recording = true
var rewinding = false

var positionToIntegrate = Vector2.ZERO;
var integrating = false;

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		sleeping = false
	
	if Input.is_action_just_pressed("rewind"):
		if rewinding:
			_start_recording()
		else:
			_start_rewinding()
	rewind_effect()

func rewind_effect():
	if recording:
		pos.append(global_position)
		lineal_v.append(linear_velocity)
		if pos.size() > 240:
			pos.remove(0)
			lineal_v.remove(0)
	if rewinding:
		if pos.size() > 0:
			global_position = pos[pos.size() - 1]
			last_v = lineal_v[lineal_v.size() - 1]
			pos.remove(pos.size() - 1)
			lineal_v.remove(lineal_v.size() - 1)
		else:
			linear_velocity = last_v
			_start_recording()
			

func _integrate_forces(state):
	if (integrating):
		state.transform.origin = positionToIntegrate
		integrating = false
	
	

func _start_rewinding():
	mode = RigidBody2D.MODE_KINEMATIC
	recording = false
	rewinding = true

func _start_recording():
	rewinding = false
	recording = true
	integrating = true
	positionToIntegrate = global_position
	mode = RigidBody2D.MODE_RIGID

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	_start_recording()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
