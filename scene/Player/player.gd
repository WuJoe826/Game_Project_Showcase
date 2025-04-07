extends CharacterBody2D

@export var speed = 200
@export var friction = 1
@export var acceleration = 1
var current_direction

func get_input():
	var input = Vector2()
	if Input.is_action_pressed('right'):
		input.x += 1
		current_direction = "right"
	if Input.is_action_pressed('left'):
		input.x -= 1
		current_direction = "left"
	if Input.is_action_pressed('down'):
		input.y += 1
		current_direction = "down"
	if Input.is_action_pressed('up'):
		input.y -= 1
		current_direction = "up"
	return input
	
func _physics_process(_delta):
	var direction = get_input()
	if direction.length() > 0:
		if direction.x * abs(direction.y) > 0:
			current_direction = "right"
		elif direction.x * abs(direction.y) < 0:
			current_direction = "left"
		play_player_animation(1);
		velocity = velocity.lerp(direction.normalized() * speed, acceleration)
	else:
		play_player_animation(0);
		velocity = velocity.lerp(Vector2.ZERO, friction)
	move_and_slide()

func play_player_animation(movement):
	var direction = current_direction
	var animation = $player_outline
	if movement == 1: ## walking
		if direction == "right":
			animation.play("walk_hori")
			animation.flip_h = false
		elif direction == "left":
			animation.play("walk_hori")
			animation.flip_h = true
		elif direction == "up":
			animation.play("walk_up")
			animation.flip_h = false
		elif direction == "down":
			animation.play("walk_down")
			animation.flip_h = false
	elif movement == 2: ## dash
		pass
	elif movement == 0: ## idle 
		if direction == "right":
			animation.play("idle_hori")
			play_sword_animation("idle_right")
			animation.flip_h = false
		elif direction == "left":
			animation.play("idle_hori")
			play_sword_animation("idle_left")
			animation.flip_h = true
		elif direction == "up":
			animation.play("idle_up")
			animation.flip_h = false
		elif direction == "down":
			animation.play("idle_down")
			animation.flip_h = false
		
func play_sword_animation(directions):
	var direction = directions
	var upper_sword = $sword_upper
	var lower_sword = $sword_lower
	
	if direction == "idle_right":
		upper_sword.play("idle_hori")
		lower_sword.play("idle_hori")
		upper_sword.flip_h = false
		lower_sword.flip_h = false
	elif direction == "idle_left":
		upper_sword.play("idle_hori")
		lower_sword.play("idle_hori")
		upper_sword.flip_h = true
		lower_sword.flip_h = true
	##elif direction == "up":
		##animation.play("walk_up")
		##animation.flip_h = false
	##elif direction == "down":
		##animation.play("walk_down")
		##animation.flip_h = false
