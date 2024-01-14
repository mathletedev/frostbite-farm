extends "item.gd"

@export var plant_scene: PackedScene
@export var count: int = 3

@onready var text_label: RichTextLabel = $RichTextLabel
@onready var sprite: Sprite2D = $Sprite2D

func _custom_ready() -> void:
	text_label.text = str(count)

func _custom_process(_delta):
	if picked_up && Input.is_action_just_released("interact"):
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

		count -= 1

		var plant: Node2D = plant_scene.instantiate()
		plant.position = point
		get_tree().root.add_child(plant)

		text_label.text = str(count)

		if count == 0:
			queue_free()
