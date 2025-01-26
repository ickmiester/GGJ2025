extends Node2D

@export_file("*.tscn") var MainMenuScene:String
@export_file("*.tscn") var CreditScene:String
@export_file("*.tscn") var InfoScene:String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file(InfoScene)


func _on_next_button_pressed() -> void:
	get_tree().change_scene_to_file(MainMenuScene)