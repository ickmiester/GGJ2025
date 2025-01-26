extends Node2D

@export var direction: Vector2
signal win
signal lose
var currentSpeed = Vector2.ZERO
var maxSpeed = Vector2.ZERO
var consecutiveAccel = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(Input.is_action_just_pressed("reset")):
		get_tree().reload_current_scene()
		pass
	$Wheel.velocity *= 0.95
	if(Input.is_action_pressed("left")):
		consecutiveAccel += 1
		#print("Left Pressed")
		$Wheel.velocity += Vector2(-35 - consecutiveAccel**0.5, 0) * scale
		#$Wheel/WheelSprite.rotate(-PI/20)
		if($Wheel.is_on_floor()):
			$Wheel/WheelSprite.play()
	if(Input.is_action_pressed("right")):
		consecutiveAccel += 1
		#print("Right Pressed")
		$Wheel.velocity += Vector2(35 + consecutiveAccel**0.5, 0) * scale
		#$Wheel/WheelSprite.rotate(PI/20)
		if($Wheel.is_on_floor()):
			$Wheel/WheelSprite.play()
	$Wheel.velocity += Vector2(0, 40) * scale
	if(Input.is_action_just_pressed("jump")):
		if($Wheel.is_on_floor()):
			$Wheel.velocity+= Vector2(0, -1800) * scale
			$Wheel/WheelSprite.frame = 0;
			$Wheel/WheelSprite.pause()
			$JumpAudio.play()
	currentSpeed = $Wheel.velocity
	if(currentSpeed.x > maxSpeed.x):
		maxSpeed = currentSpeed
		#print("New Max Speed!" + str(maxSpeed.x))
	if(!Input.is_action_pressed("left") and !Input.is_action_pressed("right")):
		consecutiveAccel = 0;
		if($Wheel.is_on_floor()):
			$Wheel/WheelSprite.frame = 1;
		$Wheel/WheelSprite.pause()
		
	$Wheel.move_and_slide()
	if abs($Wheel.velocity.x) > 20 and $Wheel.is_on_floor():
		if $RollAudio.finished: 
			$RollAudio.play()
	else:
		$RollAudio.stop()
	
		
	#make body fall if off-center
	var direction_angle = $Wheel.to_global($Wheel.position) - $Body.to_global($Body.position)
	direction = direction_angle
	#if abs(direction_angle.normalized().x) > .9:
	#	$Body.position.y += (.95-direction_angle.normalized().y) * 2
		#$BodyAudio.play()
		#print("unstable!")
	#else:
		#if direction_angle.y > 0:
	$Body.position.y -= abs((direction_angle.normalized().y)) * 100
		
	#Rotate body to face center of wheel
	#Adjust body position to be a static distance from wheel
	$Body.position = $Wheel.position - (($Wheel.position - $Body.position).normalized() * 180)
	#$Body.look_at($Wheel.to_global($Wheel.position))
	$Body/BodyCollision/SpriteContainer/BodySprite.rotation = ($Wheel.to_global($Wheel.position) - $Body.to_global($Body.position)).angle()
	var body = $Body
	var parent = body.get_parent()
	#body.reparent($Wheel)
	
	if(Input.is_action_pressed("balance left")):
		body.rotate(-PI/90)
		$WheelAudio.play()
	if(Input.is_action_pressed("balance right")):
		body.rotate(PI/90)
		$WheelAudio.play()
		
	#body.reparent(parent)
	body.get_node("BodyCollision/SpriteContainer/BodySprite").play()
	$Body.move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	print("onEnter")
	emit_signal("win")
	pass # Replace with function body.
