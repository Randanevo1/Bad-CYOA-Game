extends Button

export(String) var scene_to_load

func _on_MenuButton_button_up():
	get_tree().change_scene(scene_to_load)
