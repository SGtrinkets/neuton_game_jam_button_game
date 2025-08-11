extends CharacterBody2D

@onready var enemy_timer : Timer = $Timer
@onready var sprite : Sprite2D = $Sprite2D
@onready var animation_player : AnimationPlayer = $AnimationPlayer

const bomb_scene = preload("res://scenes/bomb.tscn")
var player_detected : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	enemy_timer.start()

func _on_head_detect_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		animation_player.play("death")


func _on_timer_timeout() -> void:
	sprite.flip_h = !sprite.flip_h
	
	if player_detected:
		# Spawn bomb
		var bomb = bomb_scene.instantiate()
		get_parent().add_child(bomb)

		# Position bomb near enemy
		var offset
		if sprite.flip_h:
			offset = -100 
		else:
			offset = 100
		
		bomb.global_position = self.global_position + Vector2(offset, 0)
		
		# Give bomb a velocity based on facing direction
		if sprite.flip_h:
			bomb.velocity = Vector2(-200, 0)  # Left
		else:
			bomb.velocity = Vector2(200, 0)   # Right
	
	enemy_timer.start()


func _on_player_detect_body_entered(body: Node2D) -> void:
	player_detected = true


func _on_block_detect_body_entered(body: Node2D) -> void:
	if body.is_in_group("button_platform"):
		queue_free()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "death":
		self.queue_free()
