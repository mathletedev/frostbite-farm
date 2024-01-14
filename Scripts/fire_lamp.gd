extends "item.gd"

@export var warmth_radius: float = 50
@export var warmth_colour: Color = "#D9D7A1"
@export var pulse_rate: float = 0.005
@export var lifetime: int = 20

@onready var light: PointLight2D = $PointLight2D
@onready var timer: Timer = $Timer
@onready var bar: TextureProgressBar = $TextureProgressBar
@onready var lifetime_countdown: int = lifetime

func get_type() -> String:
	return "fire_lamp"

func _custom_ready() -> void:
	timer.timeout.connect(_on_timer)

func _draw() -> void:
	var colour = warmth_colour
	colour.a = (sin(Time.get_ticks_msec() * pulse_rate) + 1) / 4 + 0.25
	draw_circle_arc(Vector2.ZERO, warmth_radius, 0, 360, colour)

func _custom_process(_delta: float) -> void:
	queue_redraw()
	light.energy = (sin(Time.get_ticks_msec() * pulse_rate) + 1) / 4 + 0.5

func draw_circle_arc(center, radius, angle_from, angle_to, color):
	var nb_points = 32
	var points_arc = PackedVector2Array()

	for i in range(nb_points + 1):
		var angle_point = deg_to_rad(angle_from + i * (angle_to-angle_from) / nb_points - 90)
		points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)

	for index_point in range(nb_points):
		draw_line(points_arc[index_point], points_arc[index_point + 1], color, 1)

func _on_timer() -> void:
	lifetime_countdown -= 1
