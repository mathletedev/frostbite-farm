extends "item.gd"

@export var plant_scene: PackedScene
@export var count: int = 3
@export var bool_plant: int = 1;

@onready var text: RichTextLabel = $RichTextLabel
@onready var sprite: Sprite2D = $Sprite2D

func _custom_process(_delta):
	if picked_up && Input.is_action_just_released("interact") && bool_plant == 1:
		if (count > 0):
			count -= 1
			if (count == 0):
				text.queue_free()
				sprite.queue_free();
				bool_plant = 0;
			else:
				text.text = str(count)
		var plant: Node2D = plant_scene.instantiate()
		#neal write code to snap to tile
		plant.position = player.position
		get_tree().root.add_child(plant)
