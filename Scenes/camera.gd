extends Camera2D

@export var player_path: NodePath
@export var tween_speed = 3

var player: Node2D

func _ready():
	player = get_node(player_path)
	position = player.position

func _process(delta):
	position += (player.position - position) * tween_speed * delta
