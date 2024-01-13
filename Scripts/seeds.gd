extends "item.gd"

@export var plant_scene: PackedScene

func _custom_process(_delta):
	if picked_up && Input.is_action_just_released("interact"):
		var plant: Node2D = plant_scene.instantiate()
		plant.position = player.position
		get_tree().root.add_child(plant)
