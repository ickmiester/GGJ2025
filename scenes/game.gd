extends Node2D

signal win
signal lose
@export var board_scene: PackedScene
@export_file("*.tscn") var gameOverScene: String
@export var character:PackedScene
var player: Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#$BoardPath/BoardFollow/board.position = $StartPosition.position
	$BoardPath/BoardFollow.progress_ratio = 0
	player = character.instantiate()
	player.position.x = 300
	player.position.y = 200
	add_child(player)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$BoardPath/BoardFollow.progress += 100 * delta
	pass
	


func _on_win_button_pressed() -> void:
	emit_signal("win")
	get_tree().change_scene_to_file(gameOverScene)


func _on_lose_button_pressed() -> void:
	emit_signal("lose")
	get_tree().change_scene_to_file(gameOverScene)
