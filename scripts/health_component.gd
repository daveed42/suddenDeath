extends Node2D
class_name HealthComponent

@export var isAlive : bool

func _ready() -> void:
	isAlive = true

func hit():
	isAlive = false #Is this needed?
	get_parent().queue_free()

func _on_hitbox_component_area_entered(area: Area2D) -> void:
	print("Area parent: ", area.get_parent(), " Self parent: ", self.get_parent())
	if area.get_parent() != self.get_parent():
		hit()
