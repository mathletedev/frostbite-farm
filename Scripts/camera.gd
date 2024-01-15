extends Camera2D

@export var tween_speed = 3

@onready var player: Node2D = get_node("%Player")

func _ready() -> void:
	position = player.position

func _physics_process(delta: float) -> void:
	position += (player.position - position) * tween_speed * delta
