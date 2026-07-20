extends RayCast3D

func _process(delta: float) -> void:
	var area = get_collider()
	if area is InteractionBox3D:
		area.hover()
		if Input.is_action_just_pressed("interact"):
			area.interact()
