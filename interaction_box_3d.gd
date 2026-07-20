@tool
extends Area3D
class_name InteractionBox3D
@onready var label: Label3D = $Label
var labelOS;

signal interacted
signal hovered
signal hoveredEND

func _ready() -> void:
	labelOS=label.scale
	label.scale=Vector3.ZERO
	if !Engine.is_editor_hint():
		#stuff to do ingame but not in editor
		pass
	set_collision_layer_value(1, false)
	set_collision_mask_value(1, false)
	set_collision_layer_value(4, true)

func interact():
	interacted.emit()

func hover():
	var tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_QUAD)
	tween.tween_property(label, "scale", labelOS, 0.1)
	label.show()
	hovered.emit()
	
func hoverEND():
	var tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_QUAD)
	tween.tween_property(label, "scale", Vector3.ZERO, 0.1)
	hoveredEND.emit()
