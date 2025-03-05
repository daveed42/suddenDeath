extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_hitbox_area_entered(area: Area2D) -> void:
	print(area.name)
	if area.name == "Sword":
		queue_free()
		print("hit by sword!")
	else:
		print("not a sword!")
	
