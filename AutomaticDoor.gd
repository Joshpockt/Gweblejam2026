extends Node3D

var toggled=false;

@onready var open: AudioStreamPlayer3D = $Open
@onready var close: AudioStreamPlayer3D = $Close


@export_category("References")
@export var leftSide:Node3D;
@export var rightSide:Node3D;
@export var Player:CharacterBody3D;

@export_category("Properties")
@export var open_distance=1.2;
@export var ProximityToOpen=3;
@export var OpenSpeed=.3

var originalLS;
var originalRS;


func _ready() -> void:
	originalLS=leftSide.position
	originalRS=rightSide.position

func _process(delta: float) -> void:
	if Player.global_position.distance_to(global_position) < ProximityToOpen:
		if !toggled:
			toggled=true
			var tween = get_tree().create_tween()
			tween.set_trans(Tween.TRANS_QUAD)
			tween.set_parallel(true)
			open.play()
			tween.tween_property(leftSide, "position", leftSide.position + Vector3(0,0,open_distance), OpenSpeed)
			tween.tween_property(rightSide, "position", rightSide.position - Vector3(0,0,open_distance), OpenSpeed)
	else:
		if toggled:
			toggled=false
			close.play()
			var tween = get_tree().create_tween()
			tween.set_trans(Tween.TRANS_QUAD)
			tween.set_ease(Tween.EASE_IN)
			tween.set_parallel(true)
			tween.tween_property(leftSide, "position", originalLS, OpenSpeed)
			tween.tween_property(rightSide, "position", originalRS, OpenSpeed)
