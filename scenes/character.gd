extends Node2D

@export var direction: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(Input.is_action_just_pressed("reset")):
		get_tree().reload_current_scene()
		pass
	$Wheel.velocity *= 0.85
	if(Input.is_action_pressed("left")):
		#print("Left Pressed")
		$WheelAudio.play()
		$Wheel.velocity += Vector2(-100, 0)
		$Wheel/WheelSprite.rotate(-PI/20)
	if(Input.is_action_pressed("right")):
		#print("Right Pressed")
		$WheelAudio.play()
		$Wheel.velocity += Vector2(100, 0)
		$Wheel/WheelSprite.rotate(PI/20)
	$Wheel.move_and_slide()
	
	#make body fall if off-center
	var direction_angle = $Wheel.to_global($Wheel.position) - $Body.to_global($Body.position)
	direction = direction_angle
	if abs(direction_angle.x) > 40:
		$Body.position.y += (1-direction_angle.normalized().y) * 8
		#$BodyAudio.play()
		#print("unstable!")
		
	#Rotate body to face center of wheel
	#Adjust body position to be a static distance from wheel
	$Body.position = $Wheel.position - (($Wheel.position - $Body.position).normalized() * 150)
	#$Body.look_at($Wheel.to_global($Wheel.position))
	$Body/BodyCollision/SpriteContainer/BodySprite.rotation = ($Wheel.to_global($Wheel.position) - $Body.to_global($Body.position)).angle()
	$Body.move_and_slide()
