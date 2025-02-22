extends Area2D
@onready var animation= $CanvasLayer/AnimationPlayer
@onready var colorrect = $CanvasLayer/ColorRect

@export var next_scene: String = "res://springstarfields.tscn"  # Set this in the Inspector

func _on_body_entered(body):
	if body is Player: 
		transition_to_scene()

func transition_to_scene():
	if next_scene.is_empty():
		print("Error: next_scene is not set!")
		return
	colorrect.visible = true
	animation.play("fadein")
	print("should be fading out")
	await get_tree().create_timer(0.8).timeout
	animation.play("fadeout")
	get_tree().change_scene_to_file(next_scene)

	# Call the transition effect properly
