extends Node

@onready var play: Button = $UI/Play
@onready var exit: Button = $UI/exit


func _ready() -> void:
	exit.pressed.connect(func():
		get_tree().quit())
