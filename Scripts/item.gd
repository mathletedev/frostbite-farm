extends Area2D

@export var player_path: NodePath = "%Player"
@export var picked_up_scale: float = 0.8
@export var picked_up_opacity: float = 0.8
@export var y_offset: float = 30
@export var lerp_speed = 10
@export_flags_2d_physics var mask: int = 4

@onready var arrow_scene: PackedScene = preload("res://Scenes/arrow.tscn")

var can_pick_up: bool = false;
var picked_up: bool = false;
var player: Node2D
var arrow: Node2D = null

func get_type() -> String:
	return ""

func _custom_ready() -> void:
	pass

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)

	player = get_node(player_path)

func _custom_process(_delta: float) -> void:
	pass

func _process(delta: float) -> void:
	_custom_process(delta)

	if Input.is_action_just_released("pick_up"):
		pick_up()

func _physics_process(delta) -> void:
	if picked_up:
		position += (player.position + Vector2.UP * y_offset * (-1 if player.velocity.y < 0 else 1) - position) * lerp_speed * delta

func pick_up() -> void:
	if !picked_up && (!can_pick_up || GameManager.holding != ""):
		return

	if picked_up:
		var point: Vector2 = Vector2.ZERO
		point.x = (floor(player.position.x / 32)) * 32 + 16
		point.y = (floor((player.position.y + GameManager.PLACE_OFFSET) / 32)) * 32 - 16

		var parameters := PhysicsPointQueryParameters2D.new()
		parameters.position = point
		parameters.collide_with_areas = true
		parameters.collide_with_bodies = true
		parameters.collision_mask = mask
		var collisions := get_world_2d().direct_space_state.intersect_point(parameters)
		if collisions.size() > 0:
			return
	
	picked_up = !picked_up
	GameManager.holding = get_type() if picked_up else ""

	scale.x = picked_up_scale if picked_up else 1.0
	scale.y = scale.x
	
	modulate.a = picked_up_opacity if picked_up else 1.0

	if !picked_up:
		position = player.position

func _on_area_entered(other: Area2D) -> void:
	if other.name != "Interact" || picked_up:
		return

	can_pick_up = true

	arrow = arrow_scene.instantiate()
	arrow.position.y = -20
	add_child(arrow)

func _on_area_exited(other: Area2D) -> void:
	if other.name != "Interact":
		return

	can_pick_up = false

	if arrow != null:
		arrow.queue_free()
