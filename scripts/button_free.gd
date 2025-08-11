extends StaticBody2D

@onready var sprite : Sprite2D = $Sprite2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	create_tween().tween_property(self, "modulate:a", 0, 5.0)


func _on_timer_timeout() -> void:
	self.queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("bomb"):
		self.queue_free()


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("bomb"):
		self.queue_free()
