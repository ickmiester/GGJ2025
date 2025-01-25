extends RigidBody2D
@export var speed = 400
#@onready var _follow :PathFollow2D = get_parent()
var screen_size
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	
	#_follow.progress_ratio = 0
	#var tween :Tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	#tween.tween_property(_follow, 'progress_ratio', 1, 1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#$Path2D/PathFollow2D.offset += 250 * delta
	#var velocity = Vector2.ZERO
	#if Input.is_action_pressed("board_right"):
	#	velocity.x += 1
	#	
	#if velocity.length() > 0:
	#	velocity = velocity.normalized() * speed
	#	
	#position += velocity * delta
	#position = position.clamp(Vector2.ZERO, screen_size)
	pass
	
	
func start(pos):
	position = pos
	show()
