extends Node2D

const SPEED = 50
const BUBBLE = preload("res://scenes/bubble.tscn")
const MIN_WAIT_TIME = 1 #minimum timer for bubbles to spawn
const MAX_WAIT_TIME = 5 #maximum timer for bubbles to spawn
const MIN_BUBBLE_SCALE = 0.2
const MAX_BUBBLE_SCALE = 0.8

var direction: int = 1
var move_max_distance : int = 100
var initial_position: float
var nextWaitTime: int = randi_range(1, 3) #initial wait time for bubble spawn

@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var spawn_timer: Timer = $SpawnTimer
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _ready() -> void:
	initial_position = position.x
	spawn_timer.set_wait_time(nextWaitTime)
	spawn_timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#Raycast to collide and bounce between screen walls
	#if ray_cast_right.is_colliding():
		#direction = -1
		#animated_sprite_2d.flip_h = false
	#if ray_cast_left.is_colliding():
		#direction = 1
		#animated_sprite_2d.flip_h = true
		
	#bounce between a distance
	if position.x > initial_position + move_max_distance || position.x < initial_position - move_max_distance:
		if position.x > initial_position + move_max_distance:
			direction = -1
			animated_sprite_2d.flip_h = false
			$EnemyTurnAudio.play()
		if position.x < initial_position + move_max_distance:
			direction = 1
			animated_sprite_2d.flip_h = true
			$EnemyTurnAudio.play()
		
	position.x += direction * SPEED * delta

func _on_spawn_timer_timeout() -> void:
	animated_sprite_2d.play("bubble")
	
func instantiate_bubble() -> void:
	var bubbleInstance = BUBBLE.instantiate()
	bubbleInstance.position += Vector2(direction * 100, -12)
	var scaleValue = randf_range(MIN_BUBBLE_SCALE, MAX_BUBBLE_SCALE)
	bubbleInstance.scale = Vector2(scaleValue, scaleValue)
	$EnemyBubbleAudio.play()
	add_child(bubbleInstance)

func _on_animated_sprite_2d_animation_finished() -> void:
	nextWaitTime = randi() % MAX_WAIT_TIME + MIN_WAIT_TIME
	spawn_timer.set_wait_time(nextWaitTime)
	animated_sprite_2d.play("idle")


func _on_animated_sprite_2d_frame_changed() -> void:
	if animated_sprite_2d.animation == "bubble" && animated_sprite_2d.frame == 2:
		instantiate_bubble()


func _on_killzone_body_entered(body: Node2D) -> void:
	print("Enemy Entered by " + str(body))
	if(body.name == "Wheel" or body.name == "Body"):
		body.get_parent().emit_signal("lose")
	pass # Replace with function body.
