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
	$BoardPath/BoardFollow/board/Camera2D/CanvasLayer/LevelIndicator/ProgressBar.value = 0;
	_instantiate_new_player()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$BoardPath/BoardFollow.progress += $BoardPath/BoardFollow/board.speed * delta
	$BoardPath/BoardFollow/board/Camera2D/CanvasLayer/LevelIndicator/ProgressBar.value = $BoardPath/BoardFollow.progress_ratio * $BoardPath/BoardFollow/board/Camera2D/CanvasLayer/LevelIndicator/ProgressBar.max_value
	pass
	

func _instantiate_new_player() -> void:
	$BoardPath/BoardFollow/board.remove_child(player)
	player = character.instantiate()
	player.position.x = 0
	player.position.y = -50
	player.scale = Vector2(0.25, 0.25)
	$BoardPath/BoardFollow/board.add_child(player)

func _on_win_button_pressed() -> void:
	emit_signal("win")
	get_tree().change_scene_to_file(gameOverScene)


func _on_lose_button_pressed() -> void:
	emit_signal("lose")
	get_tree().change_scene_to_file(gameOverScene)


func _on_new_path_button_pressed() -> void:
	
	$BoardPath.curve =Curve2D.new()
	var screenx = get_viewport().size.x
	var screeny = get_viewport().size.y
	var marginx = 50
	var marginy = 50
	var xscaler = 10
	var curvescaler = 3
	var points = randf_range(4,20)
	
	var pointarray = PackedVector2Array()
	
	pointarray.append(Vector2(marginx,screeny/2))
	for n in range(points):
		pointarray.append(Vector2((marginx+screenx/points*n)*xscaler,randf_range(marginx,screeny-marginy)))
	pointarray.append(Vector2((screenx-marginx)*xscaler,screeny/2))	

	$BoardPath.curve.add_point(pointarray[0], Vector2(0,0), (pointarray[1]-pointarray[0])/curvescaler)
	for n in range(1, points-1):
		$BoardPath.curve.add_point(pointarray[n+1], (pointarray[n-1]-pointarray[n])/curvescaler, (pointarray[n+1]-pointarray[n])/curvescaler)
	$BoardPath.curve.add_point(pointarray[points+1], (pointarray[points-1]-pointarray[points])/curvescaler, Vector2(0,0))
	
	_instantiate_new_player()
	$BoardPath/BoardFollow.progress_ratio = 0
