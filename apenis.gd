extends Node3D

var t =0
var st = Vector3.ZERO


func _ready() -> void:
	st=global_position


func _process(delta: float) -> void:
	t+=delta
	var s = sin(t*1)*.1
	var c = cos(t*1)*.2
	global_position=st+Vector3(s,c,0)
