extends CharacterBody2D

var walking = false
var idle = false

var xdir = 1 
var ydir = 1
var speed = 5

var moving_vertical_horizontal = 1

func _ready():
	walking = true
	randomize()
	
	
func _physics_process(delta: float) -> void:
	var wait_time = 1
	if walking == false:
		var x = randf_range(1, 2)
		if x > 1.5:
			moving_vertical_horizontal = 1
		else:
			moving_vertical_horizontal = 2
			
	if walking == true:
		$AnimatedSprite.play("walking")
		if moving_vertical_horizontal == 1:
			if xdir == -1:
				$AnimatedSprite.flip_h = true
			if xdir == 1:
				$AnimatedSprite.flip_h = false
			velocity.x = speed * xdir
			velocity.y = 0
		elif moving_vertical_horizontal == 2:
			velocity.y = speed * ydir
			velocity.x = 0
	if idle == true:
		$AnimatedSprite.play("Idle")
		velocity.x = 0
		velocity.y = 0
		
	move_and_slide()

func _on_walking_timer_timeout() -> void:
	var x = randf_range(1, 2)
	var y = randf_range(1, 2)
	var wait_time = randf_range(1, 4)
	
	if x > 1.5:
		xdir = 1 #вправо
	else:
		xdir = -1 #влево
		
	if y > 1.5:
		ydir = 1
	else:
		ydir = -1
	$WalkingTimer.wait_time = wait_time
	$WalkingTimer.start()


func _on_chage_state_timer_timeout() -> void:
	var wait_time = 1
	if walking == true:
		idle == true
		walking = false
		wait_time = randf_range(1, 5)
	elif idle == true:
		idle = false
		walking = true
		wait_time = randf_range(2, 6)
	$ChageStateTimer.wait_time = wait_time
	$ChageStateTimer.start()
