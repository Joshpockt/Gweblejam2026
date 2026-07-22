extends Node3D
class_name EscapePod

@onready var HoverInfo: Label3D = $HoverInfo
@onready var plr: CharacterBody3D = $"../../Characters/Mover"
@onready var fuel: AudioStreamPlayer3D = $Sounds/Fuel
@onready var error: AudioStreamPlayer3D = $Sounds/Error
@onready var interactors: Node3D = $"../../Interactors"


@export_category("Issues")
@export var no_fuel=false;
@export var seized=false;
@export var not_sealed=false;
@export var invalid_security=false;

func _process(delta: float) -> void:
	if invalid_security && interactors.SignedIn:
		invalid_security=false
		$SI.text = "Security Valid"
		$SI.modulate=Color(0.0, 1.0, 0.0, 1.0)
	if plr.holding == "GasolineTank":
		HoverInfo.text = "Insert Fuel"
	else:
		HoverInfo.text = "Repairs Needed 
for operation
"

func interact():
	if plr.holding == "GasolineTank" && no_fuel:
		no_fuel=false
		plr.DestroyHolding()
		$NF.text = "Fuel Full"
		$NF.modulate=Color(0.0, 1.0, 0.0, 1.0)
		fuel.play()
		return
	error.play()
		
func hover():
	var tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_QUAD)
	tween.tween_property(HoverInfo, "scale", Vector3.ONE, 0.1)
	HoverInfo.show()
	
	
func hoverEND():
	var tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_QUAD)
	tween.tween_property(HoverInfo, "scale", Vector3.ZERO, 0.1)
