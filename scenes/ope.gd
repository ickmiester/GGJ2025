extends Node2D

@export var roll_direction:Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += roll_direction * delta
	pass



func _on_body_entered(body: Node2D) -> void:
	print("Ope Entered by " + str(body))
	if(body.name == "Wheel" or body.name == "Body"):
		body.get_parent().emit_signal("lose")
	pass # Replace with function body.
