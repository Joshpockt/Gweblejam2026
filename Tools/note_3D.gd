@icon("uid://bhkx37gripch6")
@tool
extends Label3D
class_name Note3D

@export_multiline() var note_text : String
const SHOW := true


func _init() -> void:
	if !Engine.is_editor_hint():
		# running in game:
		if SHOW == false:
			hide()
		process_mode = Node.PROCESS_MODE_DISABLED


func _process(delta: float) -> void:
	if Engine.is_editor_hint() and OS.is_debug_build():
		#running in editor and is a debug build
		text = note_text
		billboard = BaseMaterial3D.BILLBOARD_ENABLED
