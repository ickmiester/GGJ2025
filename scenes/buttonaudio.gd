extends Node2D

@export var button: BaseButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_mouse_entered() -> void:
	$ButtonAudio.play()
	pass # Replace with function body.


func _on_mouse_exited() -> void:
	$ButtonAudio.play()
	pass # Replace with function body.
