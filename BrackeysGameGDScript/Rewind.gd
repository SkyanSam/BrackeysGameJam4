extends Node2D

export var isRotationLocked = true;
var pos = []
var lineal_v = []
var last_v
var recording = true
var rewinding = false

func _physics_process(delta):
	if Input.is_action_just_pressed("rewind"):
		if rewinding:
			_start_recording()
		else:
			_start_rewinding()
	rewind_effect()
	print(rewinding)

func rewind_effect():
	if recording:
		
		pos.append(get_parent().global_position)
		if pos.size() > 10000:
			pos.remove(0)
			#lineal_v.remove(0)
	if rewinding:
		if pos.size() > 0:
			get_parent().global_position = pos[pos.size() - 1]
			#last_v = lineal_v[lineal_v.size() - 1]
			pos.remove(pos.size() - 1)
			#lineal_v.remove(lineal_v.size() - 1)
		else:
			_start_recording()
			
	
	

func _start_rewinding():
	recording = false
	rewinding = true

func _start_recording():
	rewinding = false
	recording = true

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	_start_recording()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
