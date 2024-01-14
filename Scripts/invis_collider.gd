extends Area2D

@export var invis_collider_path: NodePath = "%InvisCollider"
@export var invis_collider_scene: PackedScene

var invis_collider: Node2D = invis_collider_scene.instantiate()

func custom_ready() -> void:
	area_entered.connect(_on_collider_entered)
	area_exited.connect(_on_collider_exited)

	invis_collider = get_node(invis_collider_path)

func _on_collider_entered(other: Area2D) -> void:
	if other.name == "Interact":
		GameManager.can_place = false

func _on_collider_exited(other: Area2D) -> void:
	if other.name == "Interact":
		GameManager.can_place = true


