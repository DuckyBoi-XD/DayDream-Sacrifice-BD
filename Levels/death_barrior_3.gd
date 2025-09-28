extends Area2D

# The next level to load when picked up
var next_level_scene: String = "res://Level/ThirdLevel.tscn"

func _ready():
	# Connect the signal to detect when the player touches the power-up
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(_body):
	call_deferred("_change_scene")

func _change_scene():
	get_tree().change_scene_to_file("res://Level/ThirdLevel.tscn")
