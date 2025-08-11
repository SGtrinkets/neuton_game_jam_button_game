extends Control

var levels = {1 : "res://scenes/level_1.tscn", 2 : "res://scenes/level_2.tscn", 3 : "res://scenes/level_3.tscn", 4 : "res://scenes/game_complete.tscn"}
@onready var music : AudioStreamPlayer2D = $level_complete_music


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameState.set_value("level", GameState.get_value("level") + 1)
	music.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_next_level_pressed() -> void:
	var level = levels[GameState.get_value("level")]
	get_tree().change_scene_to_file(level)


func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
