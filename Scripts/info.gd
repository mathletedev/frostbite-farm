extends Sprite2D

@export var bob_rate: float = 0.015
@export var bob_amplitude: float = 4

@onready var og_pos: Vector2 = position

func _process(_delta: float) -> void:
	position.y = og_pos.y + sin(Time.get_ticks_msec() * bob_rate) * bob_amplitude
