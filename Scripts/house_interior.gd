extends Node

@onready var InteractHouse: Sprite2D = get_node("House Interior")
var Player = null
var inHouseRange = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_interaction_radius_body_entered(body):
	if body.name == "Player":
		InteractHouse.visible = true
		Player = body
		inHouseRange = true
	pass 


func _on_interaction_radius_body_exited(body):
	print("player exited")
	if body.name == "Player":
		InteractHouse.visible = false
		inHouseRange = false
	pass # Replace with function body.
