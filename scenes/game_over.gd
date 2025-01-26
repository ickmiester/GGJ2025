extends Node2D

@export_file("*.tscn") var gameScene: String
@export_file("*.tscn") var mainMenuScene: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Did you win? " + str(Game.success))
	print("What level did you get to? " + str(Game.currentLevel))
	print("Your Time: " + str(snappedf(Game.totalTimeElapsed, 1)))
	print("Max Speed: " + str(snappedf(Game.maxSpeed, 1)))
	print("Distance Travelled: " + str(snappedf(Game.totalDistanceCovered/10, 1)))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_retry_button_pressed() -> void:
	Game.currentLevel = 0;
	Game.totalTimeElapsed = 0;
	Game.maxSpeed = 0;
	Game.totalDistanceCovered = 0
	get_tree().change_scene_to_file(gameScene)


func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file(mainMenuScene)
