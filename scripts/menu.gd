extends Control

@onready var main_menu : VBoxContainer = $MarginContainer/HBoxContainer/main_menu
@onready var option_menu: VBoxContainer = $MarginContainer/HBoxContainer/option_menu
@onready var audio_menu: VBoxContainer = $MarginContainer/HBoxContainer/audio_menu
@onready var control_menu: Control = $MarginContainer/HBoxContainer/control_menu

const video = preload("res://scenes/video.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	main_menu.show()
	audio_menu.hide()
	control_menu.hide()
	option_menu.hide()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	GameState.set_value("level", 1)
	GameState.set_value("pause", false)
	GameState.set_value("button_set", false)
	GameState.set_value("goal_reached", false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_pressed() -> void:
	get_tree().change_scene_to_packed(video)


func _on_options_pressed() -> void:
	main_menu.hide()
	option_menu.show()


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_back_to_options_pressed() -> void:
	audio_menu.hide()
	control_menu.hide()
	option_menu.show()


func _on_audio_pressed() -> void:
	option_menu.hide()
	audio_menu.show()


func _on_controls_pressed() -> void:
	option_menu.hide()
	control_menu.show()


func _on_back_to_menu_pressed() -> void:
	option_menu.hide()
	main_menu.show()
