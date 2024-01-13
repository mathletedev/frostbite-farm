extends CharacterBody2D

@export var max_speed: float = 150
@export var acceleration: float = 300
@export var friction: float = 1000
@export var dash_speed: float = 300
@export var dash_time: float = 0.15
@export var dash_wait: float = 1

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var dash_timer: Timer = $DashTimer
@onready var dash_waiter: Timer = $DashWait

@onready var curr_max_speed: float = max_speed

var can_dash = true

func _ready() -> void:
	dash_timer.wait_time = dash_time
	dash_timer.timeout.connect(_on_dash_timer)
	dash_waiter.wait_time = dash_wait
	dash_waiter.timeout.connect(_on_dash_waiter)

func _process(_delta: float) -> void:
	var input := get_input()

	if Input.is_action_pressed("dash") && input != Vector2.ZERO:
		dash(input)

func _physics_process(delta: float) -> void:
	var input := get_input()

	move(delta, input)
	animate()

func get_input() -> Vector2:
	var input := Vector2.ZERO
	input.x = Input.get_axis("left", "right")
	input.y = Input.get_axis("up", "down")

	return input

func move(delta: float, input: Vector2) -> void:
	if curr_max_speed != dash_speed:
		if input == Vector2.ZERO:
			if velocity.length() > friction * delta:
				velocity -= velocity.normalized() * friction * delta
			else:
				velocity = Vector2.ZERO
		else:
			velocity += input * acceleration * delta

	velocity = velocity.limit_length(curr_max_speed)

	move_and_slide()

func animate() -> void:
	if velocity.length() < 1:
		sprite.animation = "idle"
	elif velocity.y >= 0:
		sprite.animation = "run"
	else:
		sprite.animation = "up"

	if velocity.x < 0:
		sprite.flip_h = 1
	elif velocity.x > 0:
		sprite.flip_h = 0

func dash(input: Vector2) -> void:
	if !can_dash:
		return
	can_dash = false

	velocity = input.normalized() * dash_speed
	curr_max_speed = dash_speed

	dash_timer.start()
	dash_waiter.start()

func _on_dash_timer() -> void:
	curr_max_speed = max_speed

func _on_dash_waiter() -> void:
	can_dash = true
