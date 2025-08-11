extends Node

var state := {
	"level" : 1,
	"pause": false,
	"button_set":false,
	"goal_reached": false,
	"dead" : false
}

func has_value(key):
	return state.has(key)


func get_value(key):
	if state.has(key):
		return state[key]
	
	printerr("Key not present in state: ", key)


func set_value(key, value):
	state[key] = value

	
