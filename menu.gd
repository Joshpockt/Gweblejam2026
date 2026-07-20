extends Node

@onready var play: Button = $UI/Play
@onready var exit: Button = $UI/exit
var game = preload("res://ship.tscn")

func playGame():
	queue_free()
	get_tree().root.add_child(game.instantiate())
	
	

func _ready() -> void:
	play.pressed.connect(playGame)
	exit.pressed.connect(func():
		get_tree().quit())
