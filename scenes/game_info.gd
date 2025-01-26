extends Node2D

@export_file("*.tscn") var MainMenuScene:String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file(MainMenuScene)


func _on_next_button_pressed() -> void:
	pass # Replace with function body.


func _on_ggj_button_pressed() -> void:
	OS.shell_open("https://globalgamejam.org/")


func _on_igdatc_button_pressed() -> void:
	OS.shell_open("https://igdatc.org/")
