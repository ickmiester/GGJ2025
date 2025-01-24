extends Node2D

@export_file("*.tscn") var gameScene: String
@export_file("*.tscn") var mainMenuScene: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_retry_button_pressed() -> void:
	get_tree().change_scene_to_file(gameScene)


func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file(mainMenuScene)
