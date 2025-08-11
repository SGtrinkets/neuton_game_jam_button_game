extends Node2D

@onready var pause : Control = $Camera2D/PauseMenu
@onready var options : Button = $Camera2D/PauseMenu/MarginContainer/pause/options
@onready var retry : Button = $Camera2D/PauseMenu/MarginContainer/pause/retry_current_level
@onready var menu : Button = $Camera2D/PauseMenu/MarginContainer/pause/main_menu
@onready var camera : Camera2D = $Camera2D
@onready var music : AudioStreamPlayer2D = $Camera2D/music

var options_dup = load("res://scenes/options_dup.tscn")
var retry_dup = load("res://scenes/retry_dup.tscn")
var menu_dup = load("res://scenes/menu_dup.tscn")
var instance

var buttons_set : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	music.play()
	GameState.set_value("dead", false)
	GameState.set_value("pause", false)
	GameState.set_value("button_set", false)
	GameState.set_value("goal_reached", false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GameState.get_value("dead") or GameState.get_value("goal_reached"):
		music.stop()
	
	pause.global_position = camera.global_position
	if GameState.get_value("button_set") == true:
		instance = options_dup.instantiate()
		get_parent().add_child(instance)
		instance.global_position = middle_calc(options)

		instance = retry_dup.instantiate()
		get_parent().add_child(instance)
		instance.global_position = middle_calc(retry)

		instance = menu_dup.instantiate()
		get_parent().add_child(instance)
		instance.global_position = middle_calc(menu)
		
		GameState.set_value("button_set", false)

	#print($Camera2D/PauseMenu/MarginContainer/pause/options.global_position)
func middle_calc(button_node : Button) -> Vector2:
	var button_center_x = button_node.global_position.x + (button_node.size.x / 2.0)
	var button_center_y = button_node.global_position.y + (button_node.size.y / 2.0)
	var button_center= Vector2(button_center_x, button_center_y)

	return button_center
