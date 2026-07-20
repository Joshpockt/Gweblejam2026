extends Node3D
@export var lever:InteractionBox3D
@onready var player: CharacterBody3D = $"../Characters/Mover"
@onready var cutscene_text: Label = $"../UI/cutsceneText"


var leverToggled=false;
var inCutscene=false

func startCutscene(cameraTarget:String,TweenSpeed,DurationAfterText,Text:String):
	var cameraTargetN = $"../CutsceneTargets".find_child(cameraTarget)
	if !inCutscene:
		inCutscene=true
		player.tabout=true
		var camera= player.camera
		var camOldP = camera.global_position
		var camOldR = camera.global_rotation
		var tween = get_tree().create_tween()
		tween.set_trans(Tween.TRANS_QUAD)
		tween.set_parallel(true)
		tween.tween_property(camera,"global_rotation",cameraTargetN.global_rotation,TweenSpeed)
		tween.tween_property(camera,"global_position",cameraTargetN.global_position,TweenSpeed)
		await tween.finished
		for i in Text.length():
			cutscene_text.text=cutscene_text.text+Text.substr(i,1)
			await get_tree().create_timer(.05).timeout
		await get_tree().create_timer(DurationAfterText).timeout
		tween = get_tree().create_tween()
		tween.set_trans(Tween.TRANS_QUAD)
		tween.set_parallel(true)
		tween.tween_property(camera,"global_rotation",camOldR,.3)
		tween.tween_property(camera,"global_position",camOldP,.3)
		await tween.finished
		inCutscene=false
		player.tabout=false
		cutscene_text.text=""

func leverInteract():
	leverToggled=!leverToggled
	var pivot = lever.get_parent().find_child("pivot")
	var tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	if leverToggled:
		startCutscene("LeverCutscene",3,1,"This lever makes you want to fuck dudes...")
		tween.tween_property(pivot, "rotation_degrees", Vector3(0,90,-140), 0.4)
	else:
		tween.tween_property(pivot, "rotation_degrees", Vector3(0,90,-25), 0.4)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	lever.interacted.connect(leverInteract)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
