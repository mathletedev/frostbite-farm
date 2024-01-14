extends Area2D

@export var stages: Array[Texture]
@export var product_scene: PackedScene
@export var growth_speed: float = 10
@export var frozen_speed: int = 10

@onready var sprite: Sprite2D = $Sprite2D
@onready var growth_timer: Timer = $GrowthTimer
@onready var frozen_timer: Timer = $FrozenTimer
@onready var warning_scene: PackedScene = preload("res://Scenes/warning.tscn")
@onready var arrow_scene: PackedScene = preload("res://Scenes/arrow.tscn")
@onready var frozen_countdown: int = frozen_speed

const MY_DIALOGUE: String = "Left click to water"

var curr_stage: int = 0
var is_growing: bool = false
var touching_player: bool = false
var touching_lamp: bool = false
var arrow: Node2D = null

func _ready() -> void:
	growth_timer.wait_time = growth_speed / stages.size()
	growth_timer.timeout.connect(_on_growth_timer)
	frozen_timer.timeout.connect(_on_frozen_timer)

	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)

func _process(_delta: float) -> void:
	if Input.is_action_just_released("interact") && touching_player && GameManager.holding == "watering_can":
		is_growing = true
		growth_timer.start()
		frozen_timer.start()

func _on_area_entered(other: Area2D) -> void:
	if other.name == "Heat":
		touching_lamp = true
		frozen_countdown = frozen_speed
		sprite.modulate.a = 1

		var warning := get_node_or_null("Warning")
		if warning != null:
			warning.queue_free()
	elif other.name == "Interact":
		touching_player = true

		if arrow == null:
			arrow = arrow_scene.instantiate()
			arrow.position.y = -20
			add_child(arrow)

		if GameManager.holding == "watering_can" && !is_growing:
			GameManager.dialogue = MY_DIALOGUE
			GameManager.update_dialogue.emit()

func _on_area_exited(other: Area2D) -> void:
	if other.name == "Heat":
		touching_lamp = false

		if curr_stage != 0:
			frozen_timer.start()
	elif other.name == "Interact":
		touching_player = false

		if arrow != null:
			arrow.queue_free()
			arrow = null

		if GameManager.dialogue == MY_DIALOGUE:
			GameManager.dialogue = ""
			GameManager.update_dialogue.emit()

func _on_growth_timer() -> void:
	curr_stage += 1
	if curr_stage >= stages.size():
		var product = product_scene.instantiate()
		get_tree().root.add_child(product)
		product.position = position

		queue_free()
		return
	
	sprite.texture = stages[curr_stage]

func _on_frozen_timer() -> void:
	if touching_lamp:
		return

	frozen_countdown -= 1
	sprite.modulate.a = float(frozen_countdown) / frozen_speed

	if frozen_countdown == 3:
		var warning: Node2D = warning_scene.instantiate()
		warning.position.y = -20
		add_child(warning)

	if frozen_countdown == 0:
		queue_free()
