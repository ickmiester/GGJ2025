extends Node2D

@export_file("*.tscn") var mainScene: String

@onready var spawn_timer: Timer = $SpawnTimer
var nextWaitTime: int = 1

const BUBBLE = preload("res://scenes/bubble.tscn")
const MIN_WAIT_TIME = 1;
const MAX_WAIT_TIME = 4;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	nextWaitTime = randi() % MAX_WAIT_TIME + MIN_WAIT_TIME
	spawn_timer.set_wait_time(nextWaitTime)
	spawn_timer.start()
	#instantiate_bubble()

func _on_spawn_timer_timeout() -> void:
	instantiate_bubble()
	nextWaitTime = randi() % MAX_WAIT_TIME + MIN_WAIT_TIME
	spawn_timer.set_wait_time(nextWaitTime)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func instantiate_bubble() -> void:
	var bubbleInstance = BUBBLE.instantiate()
	var scaleValue = randf_range(0.2,0.5)
	bubbleInstance.scale = Vector2(scaleValue, scaleValue)
	
	add_child(bubbleInstance)

func _on_back_button_down() -> void:
	get_tree().change_scene_to_file(mainScene)
