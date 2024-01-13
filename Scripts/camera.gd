extends Camera2D

@export var player_path: NodePath
@export var tween_speed = 3

var player: Node2D

func _ready() -> void:
	player = get_node(player_path)
	position = player.position

func _physics_process(delta: float) -> void:
	position += (player.position - position) * tween_speed * delta
