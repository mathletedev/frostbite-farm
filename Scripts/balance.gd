extends Control

@onready var text_label: RichTextLabel = $RichTextLabel

func _ready():
	update_balance()
	GameManager.update_balance.connect(update_balance)

func update_balance() -> void:
	text_label.text = "[right]" + str(GameManager.balance) + "[/right]"
