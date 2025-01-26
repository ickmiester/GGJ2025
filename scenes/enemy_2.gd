extends CharacterBody2D

enum EnemyType {
	Uffd,
	Spike
}

@export var enemy_type: EnemyType

const SPEED = 50.0

const BUBBLE = preload("res://scenes/bubble.tscn")
const MIN_WAIT_TIME = 1 #minimum timer for bubbles to spawn
const MAX_WAIT_TIME = 5 #maximum timer for bubbles to spawn
const MIN_BUBBLE_SCALE = 0.2
const MAX_BUBBLE_SCALE = 0.8

var direction: int = 1
var move_max_distance : int = 50
var initial_position: float
var nextWaitTime: int = randi_range(1, 3) #initial wait time for bubble spawn

@onready var uffd: AnimatedSprite2D = $Uffd
@onready var spike: AnimatedSprite2D = $Spike
@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var spawn_timer: Timer = $SpawnTimer

func _ready() -> void:
	if enemy_type == EnemyType.Uffd:
		initial_position = position.x
		spawn_timer.set_wait_time(nextWaitTime)
		spawn_timer.start()
		spike.visible = false
	else:
		uffd.visible = false


func _physics_process(delta: float) -> void:
	if enemy_type == EnemyType.Uffd:
		# Add the gravity.
		if not is_on_floor():
			velocity += get_gravity() * delta
			
		if position.x > initial_position + move_max_distance || position.x < initial_position - move_max_distance:
			if position.x > initial_position + move_max_distance || ray_cast_right.is_colliding():
				direction = -1
				uffd.flip_h = false
			if position.x < initial_position + move_max_distance || ray_cast_left.is_colliding():
				direction = 1
				uffd.flip_h = true

		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

		move_and_slide()

func _on_spawn_timer_timeout() -> void:
	if enemy_type == EnemyType.Uffd:
		uffd.play("bubble")

func instantiate_bubble() -> void:
	var bubbleInstance = BUBBLE.instantiate()
	bubbleInstance.position += Vector2(direction * 100, -12)
	var scaleValue = randf_range(MIN_BUBBLE_SCALE, MAX_BUBBLE_SCALE)
	bubbleInstance.scale = Vector2(scaleValue, scaleValue)
	
	add_child(bubbleInstance)


func _on_animated_sprite_2d_animation_finished() -> void:
	nextWaitTime = randi() % MAX_WAIT_TIME + MIN_WAIT_TIME
	spawn_timer.set_wait_time(nextWaitTime)
	uffd.play("idle")


func _on_animated_sprite_2d_frame_changed() -> void:
	if uffd.animation == "bubble" && uffd.frame == 2:
		instantiate_bubble()


func _on_killzone_body_entered(body: Node2D) -> void:
	print("Enemy Entered by " + str(body))
	if(body.name == "Wheel" or body.name == "Body"):
		body.get_parent().emit_signal("lose")
