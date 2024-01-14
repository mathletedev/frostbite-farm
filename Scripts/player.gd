extends CharacterBody2D

@export var speed = 125
@export var friction:float = 50

@export var dash_speed: float = 200.0
@export var dash_time: float = .45
@export var dash_cooldown: float = .15

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var dash_timer: Timer = $DashTimer
@onready var dash_cooldown_timer: Timer = $DashCooldown

var can_dash = true
var dash_velocity = Vector2(0,0)
var input_direction = Vector2(0,0)
var in_dash = false

func _ready() -> void:
	pass

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = dash_velocity + input_direction.normalized() * speed

	return input_direction
	
func _process(delta):
	if in_dash == false: 
		input_direction = get_input()
	if Input.is_action_pressed("dash") && input_direction != Vector2.ZERO:
		dash(input_direction, delta)
	
	move_and_slide()
	animate()
	
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
		
func dash(input_direction: Vector2, delta) -> void:
	if !can_dash:
		return
	can_dash = false
	in_dash = true
	
	velocity = dash_speed * input_direction
	
	dash_timer.start()
	dash_cooldown_timer.start()
	
func _on_dash_timer_timeout():
	in_dash = false
	
func _on_dash_cooldown_timeout():
	can_dash = true	
