extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !GameState.get_value("dead") or !GameState.get_value("goal_reached"): 
		$AnimationPlayer.play("wave")
	else:
		$AnimationPlayer.play("RESET")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		GameState.set_value("goal_reached", true)
		print("Player detected!")
