extends Area2D

@export var picked_up_scale: float = 0.8
@export var picked_up_opacity: float = 0.8
@export var y_offset: float = 30
@export var lerp_speed = 10
@export_flags_2d_physics var mask: int = 4
@export var sell_price: int

@onready var player: Node2D = get_node("/root/Root/Player")
@onready var box: Node2D = get_node("/root/Root/Box")
@onready var arrow_scene: PackedScene = preload("res://Scenes/arrow.tscn")

const MY_DIALOGUE = "Press [Space] to pick up"

var touching_player: bool = false;
var picked_up: bool = false;
var arrow: Node2D = null

func get_type() -> String:
	return "item"

func get_dialogue() -> String:
	return ""

func _custom_ready() -> void:
	pass

func _ready() -> void:
	_custom_ready()

	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)

func _custom_process(_delta: float) -> void:
	pass

func _process(delta: float) -> void:
	_custom_process(delta)

	if Input.is_action_just_released("sell") && picked_up && get_type() != "watering_can":
		GameManager.balance += sell_price
		GameManager.update_balance.emit()
		GameManager.dialogue = ""
		GameManager.update_dialogue.emit()
		GameManager.holding = ""

		queue_free()

	var point: Vector2 = Vector2.ZERO
	point.x = (floor(player.position.x / 32)) * 32 + 16
	point.y = (floor((player.position.y + GameManager.PLACE_OFFSET) / 32)) * 32 - 16

	var can_place := true

	var parameters := PhysicsPointQueryParameters2D.new()
	parameters.position = point
	parameters.collide_with_areas = true
	parameters.collide_with_bodies = true
	parameters.collision_mask = mask
	var collisions := get_world_2d().direct_space_state.intersect_point(parameters)
	if collisions.size() > 0:
		can_place = false

	if picked_up:
		box.visible = can_place
		box.position = point

	if Input.is_action_just_released("pick_up"):
		pick_up(point, can_place)

func _physics_process(delta) -> void:
	if picked_up:
		position += (player.position + Vector2.UP * y_offset * (-1 if player.velocity.y < 0 else 1) - position) * lerp_speed * delta

func pick_up(point: Vector2, can_place: bool) -> void:
	if (!picked_up && (!touching_player || GameManager.holding != "")) || (picked_up && !can_place):
		return
	
	picked_up = !picked_up
	GameManager.holding = get_type() if picked_up else ""

	if picked_up:
		GameManager.holding_price = sell_price
	else:
		position = point
		box.visible = false

	scale.x = picked_up_scale if picked_up else 1.0
	scale.y = scale.x
	
	modulate.a = picked_up_opacity if picked_up else 1.0

func _on_area_entered(other: Area2D) -> void:
	if other.name != "Interact" || picked_up:
		return

	touching_player = true

	if arrow == null:
		arrow = arrow_scene.instantiate()
		arrow.position.y = -20
		add_child(arrow)
	
	GameManager.dialogue = MY_DIALOGUE + get_dialogue()
	GameManager.update_dialogue.emit()

func _on_area_exited(other: Area2D) -> void:
	if other.name != "Interact":
		return

	touching_player = false

	if arrow != null:
		arrow.queue_free()
		arrow = null

	if GameManager.dialogue == MY_DIALOGUE + get_dialogue():
		GameManager.dialogue = ""
		GameManager.update_dialogue.emit()
