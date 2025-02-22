extends Node

func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func change_scene(target_scene: String) -> void:
	get_tree().change_scene_to_file(target_scene)
