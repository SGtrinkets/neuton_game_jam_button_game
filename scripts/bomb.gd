extends CharacterBody2D

@export var gravity = 320.0
@onready var fall_sound : AudioStreamPlayer2D = $fall
@onready var animation_player : AnimationPlayer = $AnimationPlayer
@export var rotation_speed = 10.0  # Radians per second
@export var fall_direction := "right"  # Can be "left" or "right"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fall_sound.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.position.y += gravity * delta * 2 
	
	if fall_direction == "right":
		rotation += rotation_speed * delta
	else:
		rotation -= rotation_speed * delta

func _on_hit_detect_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") or body.is_in_group("button_platform") or body.is_in_group("lava") and animation_player.current_animation != "explosion":
		fall_sound.stop()
		animation_player.stop()
		gravity = 0
		rotation_speed = 0
		animation_player.play("explosion")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "explosion":
		queue_free()
