extends Control

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var CanvaLayer : CanvasLayer = $CanvasLayer
@onready var menu_button : Button = $menu

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	CanvaLayer.show()
	$Label.hide()
	$Label2.show()
	menu_button.hide()
	animation_player.play("game_complete")
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_menu_pressed() -> void:
		get_tree().change_scene_to_file("res://scenes/menu.tscn")
