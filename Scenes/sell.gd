extends Area2D

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)

func _on_area_entered(other: Area2D) -> void:
	if other.name != "Interact":

func _on_area_exited(other: Area2D) -> void:
	if other.name != "Interact":
		return
