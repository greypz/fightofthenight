extends CharacterBody2D
class_name Player
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var crouchANİMATED_sprite_2d: AnimatedSprite2D = $krauc

var is_turning: bool = false
var previous_direction: int = 0  # -1 for left, 1 for right
var idle_time: float = 0.0  # Tracks how long the character has been idle.
var is_attacking: bool = false  # Tracks if the player is currently attacking
var is_jumping: bool = false

const SPEED = 200.0
const JUMP_VELOCITY = -350.0
const IDLE_MAX_SPEED_SCALE = 4.0  # The highest speed scale for the idle animation.
const IDLE_MIN_SPEED_SCALE = 0.25  # The lowest speed scale for the idle animation.
const IDLE_DECAY_TIME = 2.0  # Time in seconds for speed scale to decrease fully.
const CROUCH_SPEED = 150.0

# Map boundaries (replace with your map's actual dimensions)
const MAP_LEFT_BOUNDARY = -2200
const MAP_RIGHT_BOUNDARY = 2200  # Replace with the width of your map
const MAP_TOP_BOUNDARY = -100000
const MAP_BOTTOM_BOUNDARY = 10000  # Replace with the height of your map

func _physics_process(delta: float) -> void:
	# Ensure the player is stopped during attack animations
	if is_attacking:
		velocity.x = 0  # Stop horizontal movement
		move_and_slide()  # Still handle physics
		return  # Ignore further input during attack

	# Handle gravity even when turning.
	if not is_on_floor():
		velocity += get_gravity() * delta

	if is_turning:
		move_and_slide()  # Allow sliding while turning.
		return  # Ignore further input while turning.

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
				

	# Handle attack
	if Input.is_action_just_pressed("attack_1") and is_on_floor():
		is_attacking = true
		animated_sprite_2d.speed_scale = 1.0  # Ensure consistent speed for attack animation
		animated_sprite_2d.play("light_attack")
		return  # Skip further processing to focus on attack

	# Get the input direction.
	var direction := Input.get_axis("move_left", "move_right")
	
	# Check for direction change and play turn_around animation.
	if direction != 0 and direction != previous_direction:
		is_turning = true
		previous_direction = direction
		animated_sprite_2d.speed_scale = 1
		animated_sprite_2d.play("turn_around")
		return

	# Handle running and idle animations.
	if direction > 0:
		animated_sprite_2d.flip_h = false
	elif direction < 0:
		animated_sprite_2d.flip_h = true

	if direction == 0:
		# Increase idle time and adjust idle animation speed.
		idle_time += delta
		var idle_speed_scale = lerp(IDLE_MAX_SPEED_SCALE, IDLE_MIN_SPEED_SCALE, clamp(idle_time / IDLE_DECAY_TIME, 0.0, 1.0))
		animated_sprite_2d.speed_scale = idle_speed_scale
		animated_sprite_2d.play("idle")
	else:
		# Reset idle time and play the running animation.
		idle_time = 0.0
		animated_sprite_2d.speed_scale = 1.0  # Reset to normal speed.
		animated_sprite_2d.play("run")
	
		#Handle stupid niggers.
	if Input.is_action_pressed("crouch") and is_on_floor():
		animated_sprite_2d.visible = false
		crouchANİMATED_sprite_2d.visible = true
		if direction > 0:
			crouchANİMATED_sprite_2d.flip_h = false
		elif direction < 0:
			crouchANİMATED_sprite_2d.flip_h = true
		if Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("move_right"):
			crouchANİMATED_sprite_2d.play("crocuuhwalk")
		else: 
			crouchANİMATED_sprite_2d.play("crochidle")
	if Input.is_action_just_released("crouch") and is_on_floor():
		animated_sprite_2d.visible = true
	# Update velocity.
		crouchANİMATED_sprite_2d.visible = false
		crouchANİMATED_sprite_2d.play("crochidle")
	if direction != 0:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if velocity.y < 0:
		animated_sprite_2d.play("jump")
	elif velocity.y > 0:
		animated_sprite_2d.play("fall")

	# Apply movement
	move_and_slide()

	# Clamp position within map bounds
	position.x = clamp(position.x, MAP_LEFT_BOUNDARY, MAP_RIGHT_BOUNDARY)
	position.y = clamp(position.y, MAP_TOP_BOUNDARY, MAP_BOTTOM_BOUNDARY)

func _on_animated_sprite_2d_animation_finished() -> void:
	# Reset is_turning if the turn_around animation finished.
	if "turn_around" in $AnimatedSprite2D.get_animation():
		is_turning = false
	
	# Reset is_attacking when the attack animation finishes
	if $AnimatedSprite2D.get_animation() == "light_attack":
		is_attacking = false
		
func player():
	pass
#hateniggers
