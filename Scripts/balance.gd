extends RichTextLabel

func _ready():
	update_balance()
	GameManager.update_balance.connect(update_balance)

func update_balance() -> void:
	text = "[right]" + str(GameManager.balance) + "[/right]"
