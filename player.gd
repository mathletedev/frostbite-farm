extends CharacterBody2D

@export var max_speed: float = 400
@export var acceleration: float = 1000
@export var friction: float = 800

@onready var sprite: Sprite2D = $Sprite2D

func _physics_process(delta):
	var input: Vector2 = get_input()

	if input == Vector2.ZERO:
		if velocity.length() > friction * delta:
			velocity -= velocity.normalized() * friction * delta
		else:
			velocity = Vector2.ZERO
	else:
		velocity += input * acceleration * delta
		velocity = velocity.limit_length(max_speed)

	if velocity.x < 0:
		sprite.flip_h = 1
	elif velocity.x > 0:
		sprite.flip_h = 0

	move_and_slide()

func get_input():
	var input: Vector2 = Vector2.ZERO
	input.x = Input.get_axis("left", "right")
	input.y = Input.get_axis("up", "down")

	return input

func dash(velocity):
	return velocity.normalized() * 100
