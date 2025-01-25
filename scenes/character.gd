extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Wheel.velocity *= 0.5
	if(Input.is_action_pressed("left")):
		#print("Left Pressed")
		$Wheel.velocity += Vector2(-200, 0)
		$Wheel/WheelSprite.rotate(-PI/20)
	if(Input.is_action_pressed("right")):
		#print("Right Pressed")
		$Wheel.velocity += Vector2(200, 0)
		$Wheel/WheelSprite.rotate(PI/20)
	$Wheel.move_and_slide()
	#Rotate body to face center of wheel
	$Body.look_at($Wheel.to_global($Wheel.position))
	#Adjust body position to be a static distance from wheel
	$Body.position = $Wheel.position - (($Wheel.position - $Body.position).normalized() * 150)
	$Body.move_and_slide()
