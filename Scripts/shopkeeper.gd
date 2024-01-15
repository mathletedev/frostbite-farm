extends Node

@export var spawn_pos: Vector2

@onready var shop_ui: CanvasLayer = $ShopUI
@onready var exit_button: Button = $ShopUI/Button
@onready var potato_button: Button = $ShopUI/ScrollContainer/Container/Potato/Button
@onready var carrot_button: Button = $ShopUI/ScrollContainer/Container/Carrot/Button
@onready var cabbage_button: Button = $ShopUI/ScrollContainer/Container/Cabbage/Button
@onready var lamp_button: Button = $ShopUI/ScrollContainer/Container/Lamp/Button
@onready var potato_seeds: PackedScene = preload("res://Scenes/plants/potato_seeds.tscn")
@onready var carrot_seeds: PackedScene = preload("res://Scenes/plants/carrot_seeds.tscn")
@onready var cabbage_seeds: PackedScene = preload("res://Scenes/plants/cabbage_seeds.tscn")
@onready var fire_lamp: PackedScene = preload("res://Scenes/fire_lamp.tscn")

const MY_DIALOGUE = "Press [F] to open shop"

var in_shop_range = false

func _ready() -> void:
	exit_button.pressed.connect(_on_exit_button_pressed)
	potato_button.pressed.connect(_on_potato_button_pressed)
	carrot_button.pressed.connect(_on_carrot_button_pressed)
	cabbage_button.pressed.connect(_on_cabbage_button_pressed)
	lamp_button.pressed.connect(_on_lamp_button_pressed)

func _process(_delta):
	if Input.is_action_just_pressed("interact(shop)") and in_shop_range:
		shop_ui.visible = true

#entered interaction radius of shopkeeper
func _on_interaction_radius_body_entered(body):
	if body.name == "Player":
		in_shop_range = true

		GameManager.dialogue = MY_DIALOGUE
		GameManager.update_dialogue.emit()

#exit interaction radius of shopkeeper
func _on_interaction_radius_body_exited(body):
	if body.name == "Player":
		in_shop_range = false
		shop_ui.visible = false

		if GameManager.dialogue == MY_DIALOGUE:
			GameManager.dialogue = ""
			GameManager.update_dialogue.emit()

# closes shop ui
func _on_exit_button_pressed():
	shop_ui.visible = false
	pass 

func _on_potato_button_pressed():
	if GameManager.balance < 3:
		return

	GameManager.balance -= 3
	GameManager.update_balance.emit()

	var item: Node2D = potato_seeds.instantiate()
	get_tree().root.add_child(item)
	item.position = spawn_pos

func _on_carrot_button_pressed():
	if GameManager.balance < 6:
		return

	GameManager.balance -= 6
	GameManager.update_balance.emit()

	var item: Node2D = carrot_seeds.instantiate()
	get_tree().root.add_child(item)
	item.position = spawn_pos

func _on_cabbage_button_pressed():
	if GameManager.balance < 20:
		return

	GameManager.balance -= 20
	GameManager.update_balance.emit()

	var item: Node2D = cabbage_seeds.instantiate()
	get_tree().root.add_child(item)
	item.position = spawn_pos

func _on_lamp_button_pressed():
	if GameManager.balance < 100:
		return
	GameManager.balance -= 100
	GameManager.update_balance.emit()

	var item: Node2D = fire_lamp.instantiate()
	get_tree().root.add_child(item)
	item.position = spawn_pos
