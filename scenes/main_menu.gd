extends Node2D

@export_file("*.tscn") var gameScene: String
@export_file("*.tscn") var infoScene: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file(gameScene)


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_info_button_pressed() -> void:
	get_tree().change_scene_to_file(infoScene)


func _on_options_button_pressed() -> void:
	pass # Replace with function body.


func _on_mute_pressed() -> void:
	pass # Replace with function body.
