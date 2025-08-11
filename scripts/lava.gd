extends Node2D

@export var rising_speed : int = 200
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !GameState.get_value("goal_reached"):
		self.position.y -= rising_speed * delta * 3
	else:
		rising_speed = 0
