extends Node

@onready var ShopUI: CanvasLayer = get_node("Shop UI")
@onready var ItemSpawnPos: Area2D = get_node("ItemSpawnPos")

@onready var PotatoSeeds: Area2D = get_node("/root/Root/PotatoSeeds")
@onready var HeatLamp = preload("res://Scenes/fire_lamp.tscn")

const MY_DIALOGUE = "Press [F] to open shop"

var Player = null
var inShopRange = false
var item

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("interact(shop)") and inShopRange:
		ShopUI.visible = true

#entered interaction radius of shopkeeper
func _on_interaction_radius_body_entered(body):
	if body.name == "Player":
		inShopRange = true

		GameManager.dialogue = MY_DIALOGUE
		GameManager.update_dialogue.emit()

#exit interaction radius of shopkeeper
func _on_interaction_radius_body_exited(body):
	if body.name == "Player":
		inShopRange = false
		ShopUI.visible = false

		if GameManager.dialogue == MY_DIALOGUE:
			GameManager.dialogue = ""
			GameManager.update_dialogue.emit()

# closes shop ui
func _on_button_pressed():
	ShopUI.visible = false
	pass 

func _on_potato_button_pressed():
	if GameManager.balance >= 3:
		GameManager.balance -= 3
		print("haha no seeds")

func _on_carrot_button_pressed():
	if GameManager.balance >= 6:
		GameManager.balance -= 6
		print("haha no seeds")
		
func _on_lamp_button_pressed():
	if GameManager.balance >= 20:
		GameManager.balance -= 20
