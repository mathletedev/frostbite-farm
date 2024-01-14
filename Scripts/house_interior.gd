extends Node

@onready var sprite: Sprite2D = $Sprite2D
@onready var house_collider: CollisionPolygon2D = $StaticBody2D/CollisionPolygon2D
@onready var tile_map: TileMap = get_node("%TileMap")

func _on_interaction_radius_body_entered(body):
	if body.name == "Player":
		sprite.modulate.a = 0.2
		tile_map.tile_set.set_physics_layer_collision_mask(0, 0)
		tile_map.tile_set.set_physics_layer_collision_layer(0, 0)

func _on_interaction_radius_body_exited(body):
	if body.name == "Player":
		sprite.modulate.a = 1
		tile_map.tile_set.set_physics_layer_collision_mask(0, 5)
		tile_map.tile_set.set_physics_layer_collision_layer(0, 5)
