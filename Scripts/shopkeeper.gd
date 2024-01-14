extends Node

@onready var InteractButton: Sprite2D = get_node("Interact Button")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("f"):
		print("shop open")
	pass


func _on_interaction_radius_body_entered(body):
	if body.name == "Player":
		InteractButton.visible = true
	pass # Replace with function body.


func _on_interaction_radius_body_exited(body):
	if body.name == "Player":
		InteractButton.visible = false
	pass # Replace with function body.
