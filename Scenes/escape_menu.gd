extends Node

@onready var player_ui: CanvasLayer = get_node("UI")
@onready var escape_menu: CanvasLayer = get_node("EscapeMenu")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("escape_menu"):
		player_ui.visible = false
		escape_menu.visible = true
		
