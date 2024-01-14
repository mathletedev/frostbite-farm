extends Node

@onready var sprite: Sprite2D = $HouseInterior
@onready var house_collider: CollisionPolygon2D = $StaticBody2D/CollisionPolygon2D
@onready var tile_map: TileMap = get_node("%TileMap")

func _on_interaction_radius_body_entered(body):
	if body.name == "Player":
		sprite.modulate.a = 0.5
		tile_map.set_layer_enabled(0,false)
		tile_map.set_layer_enabled(1,false)

func _on_interaction_radius_body_exited(body):
	if body.name == "Player":
		sprite.modulate.a = 1
