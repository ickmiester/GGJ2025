extends Node2D

signal win
signal lose
@export var board_scene: PackedScene
@export_file("*.tscn") var gameOverScene: String
@export var character:PackedScene
@export var offset:float
var player: Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#$BoardPath/BoardFollow/board.position = $StartPosition.position
	#$BoardPath/BoardFollow.progress_ratio = 0
	#$BoardPath/BoardFollow/board/Camera2D/CanvasLayer/LevelIndicator/ProgressBar.value = 0;
	_instantiate_new_player()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#$BoardPath/BoardFollow.progress += $BoardPath/BoardFollow/board.speed * delta
	#offset = $BoardPath.get_curve().get_closest_offset($BoardPath.to_local(player.get_node("Wheel").to_global(player.get_node("Wheel").position)))
	#var oldx = $BoardPath/BoardFollow.position.x;
	#$BoardPath/BoardFollow.progress = offset
	#var newx = $BoardPath/BoardFollow.position.x;
	#player.get_node("Wheel").move_local_x(oldx - newx)
	#$BoardPath/BoardFollow/board/Camera2D/CanvasLayer/LevelIndicator/ProgressBar.value = $BoardPath/BoardFollow.progress_ratio * $BoardPath/BoardFollow/board/Camera2D/CanvasLayer/LevelIndicator/ProgressBar.max_value
	pass
	

func _instantiate_new_player() -> void:
	if(player != null):
		remove_child(player)
	player = character.instantiate()
	player.position.x = 50
	player.position.y = 150
	player.scale = Vector2(0.25, 0.25)
	#$BoardPath/BoardFollow/board.add_child(player)
	add_child(player)
	var cam = $Camera2D
	cam.reparent(player.get_node("Wheel"))
	cam.offset.y=-100
	$WinArea.body_entered.connect(player._on_area_2d_body_entered)
	player.win.connect(onWin)
	

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

func onWin() -> void:
	print("and win")
	get_tree().change_scene_to_file(gameOverScene)
