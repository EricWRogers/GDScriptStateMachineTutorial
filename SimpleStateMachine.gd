extends Node
class_name SimpleStateMachine

signal pre_start()
signal post_start()
signal pre_exit()
signal post_exit()

var states = []
var current_state : String
var last_state : String
var state = null


# Called when the node enters the scene tree for the first time.
func _ready():
	for s in get_node("States").get_children():
		if s is SimpleState:
			states.append(s)

func _physics_process(delta):
	if state == null:
		return
	
	state.update_state(delta)

func set_state(_state, _message : Dictionary):
	if _state == null:
		return
	
	if state != null:
		emit_signal("pre_exit")
		state.on_exit(_state.name)
		emit_signal("post_exit")
	
	last_state = current_state
	current_state = _state.name
	
	state = _state
	
	emit_signal("pre_start")
	state.on_start(_message)
	emit_signal("post_start")
	state.on_update()

func change_state(_state_name : String, _message : Dictionary):
	for s in states:
		if _state_name == s.name:
			set_state(s,_message)
			return
