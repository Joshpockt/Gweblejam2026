extends RayCast3D
var last=null
@onready var circle: TextureRect = $"../../../../Center/Crosshair/Circle"
var circleLerp=.2
var hollowLerp=0.0
var lerpSpeed=13
@onready var mover: CharacterBody3D = $"../../../.."
@onready var eto: Label = $"../../../../ETO"


func _process(delta: float) -> void:
	circle.material.set_shader_parameter("circleSize", circleLerp)
	circle.material.set_shader_parameter("hollowSize", hollowLerp)
	var area = get_collider()
	if (area is InteractionBox3D || area is ItemInteraction || area is EscapePod) && !mover.tabout:
		circleLerp=lerp(circleLerp,.4,lerpSpeed*delta)
		hollowLerp=lerp(hollowLerp,.25,lerpSpeed*delta)
		area.hover()
		last=area
		eto.show()
		if Input.is_action_just_pressed("interact"):
			area.interact()
	elif last != null:
		eto.hide()
		last.hoverEND()
		last=null;
	else:
		eto.hide()
		circleLerp=lerp(circleLerp,.2,lerpSpeed*delta)
		hollowLerp=lerp(hollowLerp,0.0,lerpSpeed*delta)
