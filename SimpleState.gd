extends Node
class_name SimpleState

signal state_start()
signal state_updated()
signal state_exited()

var has_been_intialized : bool = false
var on_update_has_fired : bool = false

var state_machine

func on_start(_message):
	emit_signal("state_start")
	has_been_intialized = true

func on_update():
	if not has_been_intialized:
		return;
	
	emit_signal("state_updated")
	on_update_has_fired = true

func update_state(_dt : float):
	if not on_update_has_fired:
		return

func on_exit(_next_state : String):
	if not has_been_intialized:
		return
	emit_signal("state_exited")
	has_been_intialized = false
	on_update_has_fired = false
