extends Area2D

@export var stages: Array[Texture]
@export var growth_speed: float = 10

@onready var timer: Timer = $Timer

var curr_stage: int = 0
var touching_player: bool = false

func _ready():
	timer.wait_time = growth_speed / stages.size()

	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(other: CollisionObject2D) -> void:
	if other.name == "Player":
		touching_player = true

func _on_body_exited(other: CollisionObject2D) -> void:
	if other.name == "Player":
		touching_player = false
