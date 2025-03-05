extends Node2D
class_name AttackHitbox
signal attackHitboxSignal

func  _on_area_entered(area):
	print("area entered")
	attackHitboxSignal.emit(area)
