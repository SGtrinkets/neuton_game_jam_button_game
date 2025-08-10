extends CharacterBody2D


const JUMP_VELOCITY = -1700.0
var gravity : float = 150.0


var speed : float = 400.0
var acceleration : float = 50.0
var friction : float = 10.0

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D = $Sprite2D
@onready var run_sound : AudioStreamPlayer2D = $run

func _physics_process(delta: float) -> void:
	# Add the gravity.
	
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
