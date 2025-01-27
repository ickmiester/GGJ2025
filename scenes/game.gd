extends Node2D
class_name Game

signal win
signal lose
@export var board_scene: PackedScene
@export_file("*.tscn") var gameOverScene: String
@export_file("*.tscn") var winScene:String
@export_file("*.tscn") var currentScene:String
@export var character:PackedScene
@export var offset:float
var player: Node2D

static var oldDistanceCovered = 0
static var oldTimeElapsed = 0
static var oldMaxSpeed = 0
static var oldCurrentLevel = 0
static var totalDistanceCovered = 0
static var totalTimeElapsed = 0
static var maxSpeed = 0
static var currentLevel = 0
static var success = false
static var lastPlayedScene = null

@export var distanceCovered = 0;
@export var timeElapsed = 0
@export var currentSpeed = 0;
@export var spedometer:Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	success = false
	currentLevel += 1
	#$BoardPath/BoardFollow/board.position = $StartPosition.position
	#$BoardPath/BoardFollow.progress_ratio = 0
	#$BoardPath/BoardFollow/board/Camera2D/CanvasLayer/LevelIndicator/ProgressBar.value = 0;
	distanceCovered = 0
	timeElapsed = 0
	lastPlayedScene = currentScene
	print("distance:" + str(distanceCovered))
	print("totalDistance:" + str(totalDistanceCovered))
	print("timeElapsed:" + str(timeElapsed))
	print("totalTimeElapsed:" + str(totalTimeElapsed))
	print("maxSpeed:" + str(maxSpeed))
	_instantiate_new_player()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	oldDistanceCovered = totalDistanceCovered
	oldTimeElapsed = totalTimeElapsed
	oldMaxSpeed = maxSpeed
	oldCurrentLevel = currentLevel
	currentSpeed = player.currentSpeed.x
	if(player.maxSpeed.x > maxSpeed):
		maxSpeed = player.maxSpeed.x
		#print("New Max Speed!" + str(maxSpeed))
	distanceCovered += currentSpeed
	totalDistanceCovered += currentSpeed
	spedometer.text = "Current Speed: " + str(abs(snappedf(currentSpeed/10, 1)))
	#$BoardPath/BoardFollow.progress += $BoardPath/BoardFollow/board.speed * delta
	#offset = $BoardPath.get_curve().get_closest_offset($BoardPath.to_local(player.get_node("Wheel").to_global(player.get_node("Wheel").position)))
	#var oldx = $BoardPath/BoardFollow.position.x;
	#$BoardPath/BoardFollow.progress = offset
	#var newx = $BoardPath/BoardFollow.position.x;
	#player.get_node("Wheel").move_local_x(oldx - newx)
	#$BoardPath/BoardFollow/board/Camera2D/CanvasLayer/LevelIndicator/ProgressBar.value = $BoardPath/BoardFollow.progress_ratio * $BoardPath/BoardFollow/board/Camera2D/CanvasLayer/LevelIndicator/ProgressBar.max_value
	pass
	

func secondElapsed() -> void:
	timeElapsed += 1
	totalTimeElapsed += 1

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
	if($WinArea != null):
		$WinArea.body_entered.connect(player._on_area_2d_body_entered)
	player.win.connect(onWin)
	player.lose.connect(onLose)

func _on_win_button_pressed() -> void:
	emit_signal("win")
	get_tree().change_scene_to_file(winScene)


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
	call_deferred("winDeferred")
	
func winDeferred() -> void:
	success = true
	get_tree().change_scene_to_file(winScene)

func onLose() -> void:
	print("and lose")
	call_deferred("loseDeferred")
	
func loseDeferred() -> void:
	if get_tree() != null:
		get_tree().change_scene_to_file(gameOverScene)
