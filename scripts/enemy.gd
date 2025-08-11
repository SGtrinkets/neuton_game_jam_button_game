extends CharacterBody2D

@onready var enemy_timer: Timer = $Timer
@onready var sprite: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var detect_area: Area2D = $player_detect
@onready var head_detect :Area2D = $head_detect
@onready var block_detect : Area2D = $block_detect

const bomb_scene = preload("res://scenes/bomb.tscn")

var player_detected: bool = false

func _ready() -> void:
	# Connect signals locally so each enemy handles its own detection
	detect_area.body_entered.connect(_on_player_detect_body_entered)
	head_detect.body_entered.connect(_on_head_detect_body_entered)
	block_detect.body_entered.connect(_on_block_detect_body_entered)

	enemy_timer.timeout.connect(_on_timer_timeout)
	animation_player.animation_finished.connect(_on_animation_player_animation_finished)

	enemy_timer.start()

# Player stomps enemy's head
func _on_head_detect_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		animation_player.play("death")

# Bomb spawn logic
func _on_timer_timeout() -> void:
	sprite.flip_h = !sprite.flip_h
	
	if player_detected:
		var bomb = bomb_scene.instantiate()
		get_parent().add_child(bomb)

		# Position offset based on facing direction
		var offset_x = -100 if sprite.flip_h else 100
		bomb.global_position = self.global_position + Vector2(offset_x, 0)

		# Give bomb velocity based on facing direction
		bomb.velocity = Vector2(-200, 0) if sprite.flip_h else Vector2(200, 0)
	
	enemy_timer.start()

# Player enters detection area
func _on_player_detect_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_detected = true

# Enemy hits block platform
func _on_block_detect_body_entered(body: Node2D) -> void:
	if body.is_in_group("button_platform"):
		queue_free()

# Animation death cleanup
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "death":
		queue_free()


func _on_block_detect_area_entered(area: Area2D) -> void:
	if area.is_in_group("button_platform"):
		queue_free()
