extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var PlayerİnDialogArea=false


func _physics_process(delta: float) -> void:
	if PlayerİnDialogArea:
		if Input.is_action_just_pressed("interact"):
			Dialogic.start("dedeintroduce")
			
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	move_and_slide()
func _on_dialogdetectionarea_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		print(PlayerİnDialogArea)
		PlayerİnDialogArea=true
		print(PlayerİnDialogArea)


func _on_dialogdetectionarea_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		PlayerİnDialogArea=false
