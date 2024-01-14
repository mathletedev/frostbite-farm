extends "item.gd"

@export var plant_scene: PackedScene
@export var count: int = 3

@onready var text: RichTextLabel = $RichTextLabel
@onready var sprite: Sprite2D = $Sprite2D

func _custom_ready() -> void:
	text.text = format(count)

func _custom_process(_delta):
	if picked_up && Input.is_action_just_released("interact"):
		count -= 1

		var plant: Node2D = plant_scene.instantiate()
		plant.position = player.position
		get_tree().root.add_child(plant)

		text.text = format(count)

		if count == 0:
			queue_free()

func format(x: int) -> String:
	return "[center]" + str(x) + "[/center]"
