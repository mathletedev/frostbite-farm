extends "item.gd"

@export var plant_scene: PackedScene
@export var count: int = 3
@export var plant_offset: int = 32

@onready var text: RichTextLabel = $RichTextLabel
@onready var sprite: Sprite2D = $Sprite2D

func _custom_ready() -> void:
	text.text = format(count)

func _custom_process(_delta):
	if picked_up && Input.is_action_just_released("interact") && GameManager.can_place == true:
		count -= 1

		var point: Vector2 = Vector2.ZERO
		point.x = (float(player.position.x / 32)) * 32 + 16
		point.y = (float((player.position.y + plant_offset) / 32)) * 32 - 16

		var collisions = get_world_2d().direct_space_state.intersect_point()

		var plant: Node2D = plant_scene.instantiate()
		plant.position = point
		get_tree().root.add_child(plant)

		text.text = format(count)

		if count == 0:
			queue_free()

func format(x: int) -> String:
	return "[center]" + str(x) + "[/center]"
