extends "item.gd"

@export var warmth_radius: float = 50
@export var warmth_colour: Color = "#D9D7A1"
@export var pulse_rate: float = 0.005
@export var lifetime: int = 20

@onready var light: PointLight2D = $PointLight2D
@onready var timer: Timer = $Timer
@onready var bar: TextureProgressBar = $TextureProgressBar
@onready var heat_collider: CollisionShape2D = $Heat/CollisionShape2D
@onready var fire: AnimatedSprite2D = $AnimatedSprite2D
@onready var warning_scene: PackedScene = preload("res://Scenes/warning.tscn")

var lifetime_countdown: int = 0

func get_type() -> String:
	return "fire_lamp"

func get_dialogue() -> String:
	return " | Click to light"

func _custom_ready() -> void:
	bar.value = 0
	timer.timeout.connect(_on_timer)
	fire.visible = false
	heat_collider.disabled = true

func _draw() -> void:
	if lifetime_countdown <= 0:
		return

	var colour = warmth_colour
	colour.a = (sin(Time.get_ticks_msec() * pulse_rate) + 1) / 4 + 0.25
	draw_circle_arc(Vector2.ZERO, warmth_radius, 0, 360, colour)

func _custom_process(_delta: float) -> void:
	queue_redraw()

	light.energy = (sin(Time.get_ticks_msec() * pulse_rate) + 1) / 4 + 0.5 if lifetime_countdown > 0 else 0.0

	if touching_player && Input.is_action_just_released("interact"):
		bar.value = 100
		lifetime_countdown = lifetime
		fire.visible = true
		heat_collider.disabled = false

		var warning := get_node_or_null("Warning")
		if warning != null:
			warning.queue_free()

		timer.start()

func draw_circle_arc(center, radius, angle_from, angle_to, color):
	var nb_points = 32
	var points_arc = PackedVector2Array()

	for i in range(nb_points + 1):
		var angle_point = deg_to_rad(angle_from + i * (angle_to-angle_from) / nb_points - 90)
		points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)

	for index_point in range(nb_points):
		draw_line(points_arc[index_point], points_arc[index_point + 1], color, 1)

func _on_timer() -> void:
	if lifetime_countdown <= 0:
		return

	lifetime_countdown -= 1
	bar.value = (float(lifetime_countdown) / lifetime) * 100

	if lifetime_countdown == 3:
		var warning: Node2D = warning_scene.instantiate()
		warning.position.y = -20
		add_child(warning)

	if lifetime_countdown == 0:
		fire.visible = false
		heat_collider.disabled = true

		var warning := get_node_or_null("Warning")
		if warning != null:
			warning.queue_free()
