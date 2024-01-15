extends RichTextLabel

func _ready() -> void:
	update_dialogue()
	GameManager.update_dialogue.connect(update_dialogue)

func update_dialogue() -> void:
	text = "[center]" + GameManager.dialogue + "[/center]"
