extends Area2D

@export var player_path: NodePath
@export var picked_up_scale: float = 3
@export var picked_up_opacity: float = 0.5
@export var y_offset: float = 2

var can_pick_up: bool = false;
var picked_up: bool = false;
var player: Node2D

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

	player = get_node(player_path)

func _process(_delta):
	if Input.is_action_just_released("pick_up"):
		pick_up()

func _physics_process(_delta):
	if picked_up:
		position = player.position + Vector2.UP * y_offset

func pick_up() -> void:
	if !picked_up && !can_pick_up:
		return

	picked_up = !picked_up

	scale.x = picked_up_scale if picked_up else 5.0
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
