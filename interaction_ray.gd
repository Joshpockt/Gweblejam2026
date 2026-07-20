extends RayCast3D
var last=null

func _process(delta: float) -> void:
	var area = get_collider()
	if area is InteractionBox3D:
		area.hover()
		last=area
		if Input.is_action_just_pressed("interact"):
			area.interact()
	elif last != null:
		last.hoverEND()
		last=null;
