@tool
extends Area3D
class_name InteractionBox3D

signal interacted
signal hovered

func _ready() -> void:
	if !Engine.is_editor_hint():
		#stuff to do ingame but not in editor
		pass
	set_collision_layer_value(1, false)
	set_collision_mask_value(1, false)
	set_collision_layer_value(4, true)

func interact():
	interacted.emit()

func hover():
	hovered.emit()
