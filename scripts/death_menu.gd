extends Control

var levels = {1 : "res://scenes/level_1.tscn", 2 : "res://scenes/level_2.tscn", 3 : "res://scenes/level_3.tscn"}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_retry_level_pressed() -> void:
	var level = levels[GameState.get_value("level")]
	get_tree().change_scene_to_file(level)


func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
