extends Node

@onready var InteractHouse: Sprite2D = $HouseInterior
@onready var house_collider: CollisionPolygon2D = $StaticBody2D/CollisionPolygon2D
@onready var tile_map_collider: TileMap = get_node("%TileMap")

var Player = null
var inHouseRange = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_interaction_radius_body_entered(body):
	if body.name == "Player":
		InteractHouse.visible = true
		tile_map_collider.set_layer_enabled(0,false)
		tile_map_collider.set_layer_enabled(1,false)
		Player = body
		inHouseRange = true
	pass 


func _on_interaction_radius_body_exited(body):
	print("player exited")
	if body.name == "Player":
		InteractHouse.visible = false
		inHouseRange = false
		tile_map_collider.set_layer_enabled(0,true)
	pass # Replace with function body.
