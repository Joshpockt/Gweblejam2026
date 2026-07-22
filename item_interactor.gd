extends Area3D
class_name ItemInteraction
@onready var label: Label3D = $Label
var labelOS;
var plr;
@export var item_name:String
@onready var collision: CollisionShape3D = $Collision


func _ready() -> void:
	await get_tree().process_frame
	plr = get_tree().root.get_child(0).find_child("Characters").get_child(0)
	labelOS=label.scale
	label.scale=Vector3.ZERO
	set_collision_layer_value(1, false)
	set_collision_mask_value(1, false)
	set_collision_layer_value(4, true)

func activate():
	global_position+=Vector3(0,collision.shape.size.y/2,0)
	collision.disabled=false
	show()

func interact():
	if visible:
		collision.disabled=true
		hide()
		plr.EquipItem(item_name)

func hover():
	var tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_QUAD)
	tween.tween_property(label, "scale", labelOS, 0.1)
	label.show()
	
	
func hoverEND():
	var tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_QUAD)
	tween.tween_property(label, "scale", Vector3.ZERO, 0.1)
	
