extends Area2D

@export var stages: Array[Texture]
@export var growth_speed: float = 10
@export var frozen_speed: float = 10

@onready var sprite: Sprite2D = $Sprite2D
@onready var growth_timer: Timer = $GrowthTimer
@onready var frozen_timer: Timer = $FrozenTimer

var curr_stage: int = 0
var touching_player: bool = false
var touching_lamp: bool = false
var frozen_countdown: int = 10

func _ready() -> void:
	growth_timer.wait_time = growth_speed / stages.size()
	growth_timer.timeout.connect(_on_growth_timer)
	frozen_timer.wait_time = frozen_speed / 10
	frozen_timer.timeout.connect(_on_frozen_timer)

	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)

func _process(_delta: float) -> void:
	if Input.is_action_just_released("interact") && touching_player && GameManager.holding == "watering_can":
		growth_timer.start()
		frozen_timer.start()

func _on_body_entered(other: CollisionObject2D) -> void:
	if other.name == "Player":
		touching_player = true

func _on_body_exited(other: CollisionObject2D) -> void:
	if other.name == "Player":
		touching_player = false

func _on_area_entered(other: Area2D) -> void:
	if other.name == "FireLamp":
		touching_lamp = true

func _on_area_exited(other: Area2D) -> void:
	if other.name == "FireLamp":
		touching_lamp = false
		frozen_timer.start()

func _on_growth_timer() -> void:
	curr_stage += 1
	if curr_stage >= stages.size():
		return
	
	sprite.texture = stages[curr_stage]

func _on_frozen_timer() -> void:
	if touching_lamp:
		return

	queue_free()
