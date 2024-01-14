extends Area2D

@export var player_path: NodePath = "%Player"
@export var picked_up_scale: float = 0.8
@export var picked_up_opacity: float = 0.8
@export var y_offset: float = 30
@export var lerp_speed = 10

var can_pick_up: bool = false;
var picked_up: bool = false;
var player: Node2D

func get_type() -> String:
	return ""

func _custom_ready() -> void:
	pass

func _ready() -> void:
	_custom_ready()

	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

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

	picked_up = !picked_up
	GameManager.holding = get_type() if picked_up else ""

	scale.x = picked_up_scale if picked_up else 1.0
	scale.y = scale.x
	
	modulate.a = picked_up_opacity if picked_up else 1.0

	if !picked_up:
		position = player.position

func _on_body_entered(other: CollisionObject2D) -> void:
	if other.name == "Player":
		can_pick_up = true

func _on_body_exited(other: CollisionObject2D) -> void:
	if other.name == "Player":
		can_pick_up = false
