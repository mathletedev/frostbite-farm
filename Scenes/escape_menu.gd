extends Node

@onready var player_ui: CanvasLayer = get_node("UI")
@onready var escape_menu: CanvasLayer = get_node("EscapeMenu")

func _process(_delta):
	if Input.is_action_just_pressed("escape_menu"):
		player_ui.visible = false
		escape_menu.visible = true

		get_tree().paused = true

func _on_exit_button_pressed():
	get_tree().quit()

func _on_resume_button_pressed():
	player_ui.visible = true
	escape_menu.visible = false

	get_tree().paused = false
