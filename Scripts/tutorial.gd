extends Area2D

@onready var sprite: Sprite2D = $Sprite2D
@onready var ui: CanvasLayer = $UI

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)

func _on_area_entered(other: Area2D) -> void:
	if other.name != "Interact":
		return

	ui.visible = true


func _on_area_exited(other: Area2D) -> void:
	if other.name != "Interact":
		return

	ui.visible = false
