extends Node2D


#When The Start Button is pressed, it starts the game and switches to the game.
func _on_start_pressed():
	get_tree().change_scene_to_file("res://Scenes/scene_1.tscn")


func _on_quit_pressed():
	get_tree().quit()
