extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$StartButton.pressed.connect(_on_start_pressed)
	$QuitButton.pressed.connect(_on_quit_pressed)

func _on_start_pressed():
	loadLevel()
func _on_quit_pressed():
	get_tree().quit()

func loadLevel():
	get_tree().change_scene_to_file("res://FirstLevel.tscn")
