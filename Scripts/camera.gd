extends Camera2D

@export var tween_speed = 3

@onready var player: Node2D = get_node("%Player")
@onready var particles: GPUParticles2D = $GPUParticles2D

func _ready() -> void:
	position = player.position

	particles.position.y = -(Vector2(DisplayServer.window_get_size()) * get_viewport().canvas_transform.affine_inverse()).y / 2.0

func _physics_process(delta: float) -> void:
	position += (player.position - position) * tween_speed * delta
