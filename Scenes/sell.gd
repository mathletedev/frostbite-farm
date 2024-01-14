extends Area2D

var my_dialogue: String = ""

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)

func _on_area_entered(other: Area2D) -> void:
	print(other.name)
	if other.name == "Interact":
		GameManager.can_sell = true

		if GameManager.holding != "":
			my_dialogue = "Press [X] to sell (" + str(GameManager.holding_price) + ")"
			GameManager.dialogue = my_dialogue
			GameManager.update_dialogue.emit()

func _on_area_exited(other: Area2D) -> void:
	if other.name == "Interact":
		GameManager.can_sell = false

		if GameManager.dialogue == my_dialogue:
			GameManager.dialogue = ""
			GameManager.update_dialogue.emit()
