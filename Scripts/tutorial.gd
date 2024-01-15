extends Area2D

@onready var sprite: Sprite2D = $Sprite2D
@onready var text: RichTextLabel = $CollisionShape2D/RichTextLabel

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)

func _on_area_entered(other: Area2D) -> void:
	text.visible = true
	print('hi')


func _on_area_exited(other: Area2D) -> void:
	text.visible = false
	print('bye')
