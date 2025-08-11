extends CharacterBody2D

@export var bonus_jump_height = -3800
const JUMP_VELOCITY = -1700.0
var gravity : float = 150.0


var speed : float = 400.0
var acceleration : float = 50.0
var friction : float = 10.0

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D = $Sprite2D
@onready var footstep_audio : AudioStreamPlayer2D = $footstep
@onready var footstep_timer : Timer = $footstep_timer

const level_complete = preload("res://scenes/level_complete.tscn")
const death_menu = preload("res://scenes/death_menu.tscn")
const game_complete = preload("res://scenes/game_complete.tscn")
#const death = preload("res://scenes/level_1.tscn")

func _play_footstep_audio():
	if !footstep_audio.playing:
		footstep_audio.pitch_scale = randf_range(0.8, 1.2)
		footstep_audio.play()
		footstep_timer.start()


func _physics_process(delta: float) -> void:
	# Add the gravity.
	
	if GameState.get_value("goal_reached"):
		velocity = Vector2.ZERO        # Freeze velocity
		move_and_slide()               # Keep physics stable
		animation_player.play("victory")
		return                         # Skip the rest of the code
	
	if GameState.get_value("dead"):
		velocity = Vector2.ZERO        # Freeze velocity
		move_and_slide()
		return 
	
	var x_input : float = Input.get_action_strength("right") - Input.get_action_strength("left")
	var velocity_weight : float = delta * (acceleration if x_input else friction)
	velocity.x = lerp(velocity.x, x_input * speed, velocity_weight)
	
	var movement_threshold := 50.0  # Small threshold to avoid flicker between idle and run

	if not is_on_floor():
		velocity += get_gravity() * delta * 7.0
		animation_player.play("jump")
	else:
		if abs(velocity.x) > movement_threshold:
			animation_player.play("run")
		else:
			animation_player.play("idle")

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animation_player.play("jump")
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction < 0:
		sprite.flip_h = true
	elif direction > 0:
		sprite.flip_h = false

	move_and_slide()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "victory" and GameState.get_value("level") != 3:
		get_tree().change_scene_to_packed(level_complete)
	elif anim_name == "victory" and GameState.get_value("level") == 3:
		get_tree().change_scene_to_packed(game_complete)
	elif anim_name == "death":
		get_tree().change_scene_to_packed(death_menu)
		

func _on_area_collision_body_entered(body: Node2D) -> void:
	if body.is_in_group("lava"):
		animation_player.play("death")
		GameState.set_value("dead", true)
		print("lava body detected")
	if body.is_in_group("enemy"):
		if velocity.y > 0:
			velocity.y = bonus_jump_height

#THIS IS WHAT ACTUALLY IS DETECTING STUFF
func _on_area_collision_area_entered(area: Area2D) -> void:
	if area.is_in_group("lava") or area.is_in_group("bomb"):
		animation_player.play("death")
		GameState.set_value("dead", true)
	if area.is_in_group("enemy"):
		velocity.y = bonus_jump_height
