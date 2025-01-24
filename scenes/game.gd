extends Node2D

signal win
signal lose
@export_file("*.tscn") var gameOverScene: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_win_button_pressed() -> void:
	emit_signal("win")
	get_tree().change_scene_to_file(gameOverScene)


func _on_lose_button_pressed() -> void:
	emit_signal("lose")
	get_tree().change_scene_to_file(gameOverScene)
