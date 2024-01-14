extends Node

@onready var InteractButton: Sprite2D = get_node("Interact Button")
@onready var ShopUI: CanvasLayer = get_node("Shop UI")
var Player = null
var inShopRange = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("interact(shop)") and inShopRange:
		ShopUI.visible = true
	pass

#entered interaction radius of shopkeeper
func _on_interaction_radius_body_entered(body):
	if body.name == "Player":
		InteractButton.visible = true
		Player = body
		inShopRange = true
	pass 

#exit interaction radius of shopkeeper
func _on_interaction_radius_body_exited(body):
	if body.name == "Player":
		InteractButton.visible = false
		inShopRange = false
		ShopUI.visible = false
	pass 

# closes shop ui
func _on_button_pressed():
	ShopUI.visible = false
	pass 
