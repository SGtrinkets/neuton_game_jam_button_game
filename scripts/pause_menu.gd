extends Control

@onready var pause_menu: Control = $"."
@onready var pause: VBoxContainer = $MarginContainer/pause
@onready var option_menu: VBoxContainer = $MarginContainer/option_menu
@onready var audio_menu: VBoxContainer = $MarginContainer/audio_menu
@onready var control_menu: Control = $MarginContainer/control_menu

# Buttons to capture
@onready var buttons := [
	$"MarginContainer/option_menu/audio",
	$"MarginContainer/option_menu/controls",
	$"MarginContainer/option_menu/back_to_pause_menu"
]

var output_dir := "res://assets/"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pause_menu.hide()
	pause.hide()
	Engine.time_scale = 1
	option_menu.hide()
	audio_menu.hide()
	control_menu.hide()
	
	# Create output folder if it doesn't exist
	var dir = DirAccess.open(output_dir)
	if dir == null:
		DirAccess.make_dir_recursive_absolute(ProjectSettings.globalize_path(output_dir))

	for button in buttons:
		save_button_as_png(button)

	print("Buttons saved as PNG in", output_dir)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		pauseMenu()

func pauseMenu():
	if GameState.get_value("pause"):
		pause_menu.hide()
		pause.hide()
		if Engine.time_scale == 0:
			GameState.set_value("button_set", true)
		Engine.time_scale = 1
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	else:
		pause_menu.show()
		pause.show()
		Engine.time_scale = 0
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
	var paused = GameState.get_value("pause")
	paused = !paused
	
	GameState.set_value("pause", paused)


func _on_resume_pressed() -> void:
	pause_menu.hide()
	pause.hide()
	Engine.time_scale = 1
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)



func _on_options_pressed() -> void:
	pause.hide()
	option_menu.show()


func _on_retry_current_level_pressed() -> void:
	pass


func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu.tscn")


func _on_audio_pressed() -> void:
	audio_menu.show()
	option_menu.hide()


func _on_controls_pressed() -> void:
	control_menu.show()
	option_menu.hide()


func _on_back_to_pause_menu_pressed() -> void:
	option_menu.hide()
	pause.show()
	


func _on_back_to_options_pressed() -> void:
	control_menu.hide()
	audio_menu.hide()
	option_menu.show()


func save_button_as_png(button: Control):
	# Make a SubViewport exactly the size of the button
	var viewport := SubViewport.new()
	viewport.size = button.size
	viewport.transparent_bg = true
	viewport.render_target_update_mode = SubViewport.UPDATE_ONCE
	add_child(viewport)

	# Clone the button
	var clone = button.duplicate()
	clone.position = Vector2.ZERO
	viewport.add_child(clone)

	# Force render
	await get_tree().process_frame
	await get_tree().process_frame

	# Get texture & save as PNG
	var img: Image = viewport.get_texture().get_image()
	var file_path = output_dir + button.name + ".png"
	img.save_png(file_path)

	viewport.queue_free()
