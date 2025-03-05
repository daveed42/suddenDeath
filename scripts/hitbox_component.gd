extends Area2D
class_name HitboxComponent

@export var healthComponent : HealthComponent

#func damage():
#	if healthComponent:
#		healthComponent.hit()

#func _on_attack_hitbox_area_entered(area: Area2D) -> void:
#	if area is HitboxComponent:
#		print("HealthComponet parent: ", healthComponent.get_parent())
