extends Control

var levels = {1 : "res://scenes/level_1.tscn", 2 : "res://scenes/level_2.tscn", 3 : "res://scenes/level_3.tscn"}
@onready var music : AudioStreamPlayer2D = $death_music

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	music.play()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


func _on_retry_level_pressed() -> void:
	var level = levels[GameState.get_value("level")]
	get_tree().change_scene_to_file(level)


func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
