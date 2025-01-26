extends CharacterBody2D

var speed: int
var direction: Vector2
@onready var timer: Timer = $Timer

func _ready() -> void:
	set_direction_speed()
	timer.start()
	
func _physics_process(delta: float) -> void:
	velocity = direction * speed * delta
	move_and_collide(velocity)

func set_direction_speed() -> void:
	direction = Vector2(randf_range(-1,1), -1).normalized()
	speed = randi_range(50,100)

func _on_timer_timeout() -> void:
	set_direction_speed()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	$BubblePopAudio.play()
	queue_free()

func _on_killzone_body_entered(body: Node2D) -> void:
	print("Bubble Entered by " + str(body))
	if(body.name == "Wheel" or body.name == "Body"):
		$BubblePopAudio.play()
		body.get_parent().emit_signal("lose")
	pass # Replace with function body.
